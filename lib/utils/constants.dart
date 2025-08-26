class AppConstants {
  static const String appName = 'SkillCycle';
  static const String appVersion = '1.0.0';
  
  // Colors
  static const primaryColor = 0xFF6A1B9A;
  static const secondaryColor = 0xFF9C27B0;
  static const accentColor = 0xFFE91E63;
  static const backgroundColor = 0xFFF5F5F5;
  static const textColor = 0xFF333333;
  static const successColor = 0xFF4CAF50;
  static const warningColor = 0xFFFF9800;
  static const errorColor = 0xFFF44336;
  
  // Categories
  static const List<String> skillCategories = [
    'Technology',
    'Design',
    'Writing',
    'Marketing',
    'Education',
    'Health & Fitness',
    'Home Services',
    'Business',
    'Arts & Crafts',
    'Other'
  ];
  
  // Price Types
  static const List<String> priceTypes = [
    'Hourly',
    'Fixed',
    'Negotiable'
  ];
  
  // Storage paths
  static const String userImagesPath = 'user_images';
  static const String skillImagesPath = 'skill_images';
  
  // API Keys (Should be stored securely in production)
  static const String openAIKey = 'your_openai_key_here';
  static const String stripePublishableKey = 'your_stripe_key_here';
}
