import 'package:flutter/material.dart';
import 'theme_config.dart';
import 'voice_accessibility_service.dart';
import 'ask_doctor_chat_screen.dart';

void main() {
  runApp(const MedicalSuperApp());
}

class MedicalSuperApp extends StatefulWidget {
  const MedicalSuperApp({Key? key}) : super(key: key);

  @override
  State<MedicalSuperApp> createState() => _MedicalSuperAppState();
}

class _MedicalSuperAppState extends State<MedicalSuperApp> {
  ThemeMode _themeMode = ThemeMode.light;
  final VoiceAccessibilityService _voiceService = VoiceAccessibilityService();

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'المنصة الطبية الشاملة',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: _themeMode,
      home: HomeScreen(
        onToggleTheme: _toggleTheme,
        voiceService: _voiceService,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final VoiceAccessibilityService voiceService;
  final bool isDarkMode;

  const HomeScreen({
    Key? key,
    required this.onToggleTheme,
    required this.voiceService,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المنصة الطبية الشاملة'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: onToggleTheme,
            tooltip: 'تغيير الوضع (فاتح/داكن)',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // زر المساعد الصوتي
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.orange,
              ),
              onPressed: () {
                voiceService.speak("مرحباً بك، اضغط على أي قسم لطلب الخدمة أو الاستشارة");
              },
              icon: const Icon(Icons.volume_up, color: Colors.white),
              label: const Text('استمع لإرشادات التطبيق', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            const SizedBox(height: 16),

            // أقسام التطبيق الرئيسية
            _buildCategoryCard(
              context,
              title: 'تمريض منازل',
              subtitle: 'طلب ممرض معتمد للبيت فوراً',
              icon: Icons.home_repair_service,
              color: Colors.teal,
              onTap: () => voiceService.speak("قسم تمريض المنازل"),
            ),
            _buildCategoryCard(
              context,
              title: 'طوارئ الطرق SOS',
              subtitle: 'نداء استغاثة لأقرب ممرض مسعف',
              icon: Icons.warning_amber_rounded,
              color: Colors.redAccent,
              onTap: () => voiceService.speak("قسم طوارئ الطرق والإسعاف السريع"),
            ),
            _buildCategoryCard(
              context,
              title: 'اسأل طبيباً',
              subtitle: 'استشارات طبية عبر المحادثة والمكالمات',
              icon: Icons.medical_services,
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AskDoctorChatScreen(doctorName: 'أحمد سعيد')),
                );
              },
            ),
            _buildCategoryCard(
              context,
              title: 'الصيدليات والمستشفيات',
              subtitle: 'تتبع الأدوية وأسرّة الرعاية المركزة',
              icon: Icons.local_hospital,
              color: Colors.green,
              onTap: () => voiceService.speak("قسم الصيدليات والمستشفيات المجاورة"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color, size: 32),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 14)),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
