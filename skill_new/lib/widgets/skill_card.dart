import 'package:flutter/material.dart';
import '../models/skill_model.dart';

class SkillCard extends StatelessWidget {
  final SkillModel skill;
  final VoidCallback onTap;

  const SkillCard({
    Key? key,
    required this.skill,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Skill Image (placeholder for now)
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: skill.images.isNotEmpty
                    ? Image.network(skill.images.first, fit: BoxFit.cover)
                    : Icon(Icons.work, size: 40, color: Colors.grey[400]),
              ),
              const SizedBox(height: 12),
              
              // Title
              Text(
                skill.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              
              // Description
              Text(
                skill.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              
              // Price and Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${skill.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        skill.rating.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        ' (${skill.totalReviews})',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              // Categories
              if (skill.categories.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  children: skill.categories
                      .take(2)
                      .map((category) => Chip(
                            label: Text(
                              category,
                              style: const TextStyle(fontSize: 10),
                            ),
                            backgroundColor: Colors.blue[50],
                          ))
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
