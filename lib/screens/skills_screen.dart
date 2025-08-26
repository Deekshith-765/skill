import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/skill_model.dart';
import '../providers/skill_provider.dart';
import '../widgets/skill_card.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({Key? key}) : super(key: key);

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<SkillModel> _filteredSkills = [];

  @override
  void initState() {
    super.initState();
    _loadSkills();
  }

  Future<void> _loadSkills() async {
    await Provider.of<SkillProvider>(context, listen: false).fetchSkills();
    _filterSkills();
  }

  void _filterSkills() {
    final skills = Provider.of<SkillProvider>(context).skills;
    final query = _searchController.text.toLowerCase();
    
    if (query.isEmpty) {
      setState(() {
        _filteredSkills = skills;
      });
    } else {
      setState(() {
        _filteredSkills = skills.where((skill) =>
          skill.title.toLowerCase().contains(query) ||
          skill.description.toLowerCase().contains(query) ||
          skill.categories.any((category) => 
              category.toLowerCase().contains(query)) ||
          skill.tags.any((tag) => tag.toLowerCase().contains(query))
        ).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Skills'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateSkillScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search skills...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) => _filterSkills(),
            ),
          ),
          Expanded(
            child: Consumer<SkillProvider>(
              builder: (context, skillProvider, child) {
                if (skillProvider.skills.isEmpty) {
                  return const Center(
                    child: Text('No skills available yet.'),
                  );
                }

                if (_filteredSkills.isEmpty) {
                  return const Center(
                    child: Text('No skills match your search.'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _filteredSkills.length,
                  itemBuilder: (context, index) {
                    final skill = _filteredSkills[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SkillCard(
                        skill: skill,
                        onTap: () {
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SkillDetailScreen(skill: skill),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class CreateSkillScreen extends StatelessWidget {
  const CreateSkillScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Skill')),
      body: const Center(child: Text('Create Skill Screen')),
    );
  }
}

class SkillDetailScreen extends StatelessWidget {
  final SkillModel skill;

  const SkillDetailScreen({Key? key, required this.skill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(skill.title)),
      body: Center(child: Text('Details for ${skill.title}')),
    );
  }
}
