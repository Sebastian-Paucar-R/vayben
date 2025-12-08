import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  File? _qrImage;
  File? _comprobanteImage;

  Future<void> _pickImage(bool isQR) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera) ??
        await picker.pickImage(source: ImageSource.gallery);

    if (picked != null && mounted) {
      setState(() {
        if (isQR) {
          _qrImage = File(picked.path);
        } else {
          _comprobanteImage = File(picked.path);
        }
      });
    }
  }

  Widget _buildUploadBox({
    required bool isQR,
    required String title,
    required File? image,
  }) {
    return GestureDetector(
      onTap: () => _pickImage(isQR),
      child: Container(
        width: 280,
        height: 280,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade400, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20), // ← Aquí ya no hay withOpacity
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.file(image, fit: BoxFit.cover),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isQR ? Icons.qr_code_scanner : Icons.cloud_upload,
                    size: 80,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A5F7A),
        title:
            const Text('FORMA DE PAGO', style: TextStyle(color: Colors.white)),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        color: Colors.grey[50],
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              'ESCANEAR QR',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 16),
            _buildUploadBox(
                isQR: true, title: 'Toca para subir QR', image: _qrImage),
            const SizedBox(height: 50),
            const Text(
              'O SUBIR COMPROBANTE',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 16),
            _buildUploadBox(
                isQR: false,
                title: 'Toca para subir comprobante',
                image: _comprobanteImage),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
