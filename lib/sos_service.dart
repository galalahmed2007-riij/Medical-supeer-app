import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SOSService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // الحصول على الموقع الحالي عبر الـ GPS
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('خدمة الموقع غير مفعلة');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('تم رفض إذن الوصول للموقع');
      }
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // إرسال نداء طوارئ عاجل للممرضين في المحيط الجغرافي
  Future<void> triggerEmergencySOS({required String userId, String? audioNoteUrl}) async {
    Position position = await getCurrentLocation();

    await _firestore.collection('emergencies').add({
      'userId': userId,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'status': 'ACTIVE',
      'timestamp': FieldValue.serverTimestamp(),
      'audioNoteUrl': audioNoteUrl ?? '',
    });
  }
}
