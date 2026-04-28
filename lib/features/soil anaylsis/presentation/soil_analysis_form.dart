import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharsa_app/features/soil%20anaylsis/presentation/cubit/soil_analysis_cubit.dart';
import 'package:gharsa_app/features/soil%20anaylsis/presentation/soil_analysis_result_screen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_text_field.dart';

class SoilAnalysisForm extends StatefulWidget {
  const SoilAnalysisForm({super.key});

  @override
  State<SoilAnalysisForm> createState() => _SoilAnalysisFormState();
}

class _SoilAnalysisFormState extends State<SoilAnalysisForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController ec = TextEditingController();
  final TextEditingController sar = TextEditingController();
  final TextEditingController caco3 = TextEditingController();
  final TextEditingController gypsum = TextEditingController();
  final TextEditingController om = TextEditingController();
  final TextEditingController n = TextEditingController();
  final TextEditingController p = TextEditingController();
  final TextEditingController k = TextEditingController();
  final TextEditingController fe = TextEditingController();
  final TextEditingController mn = TextEditingController();
  final TextEditingController zn = TextEditingController();
  final TextEditingController cu = TextEditingController();
  final TextEditingController e_depth = TextEditingController();
  final TextEditingController ph = TextEditingController();
  final TextEditingController texture = TextEditingController();

  @override
  void dispose() {
    ec.dispose();
    sar.dispose();
    caco3.dispose();
    gypsum.dispose();
    om.dispose();
    n.dispose();
    p.dispose();
    k.dispose();
    fe.dispose();
    mn.dispose();
    zn.dispose();
    cu.dispose();
    e_depth.dispose();
    ph.dispose();
    texture.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SoilAnalysisCubit, SoilAnalysisState>(
      listener: (context, state) {
        if (state is SoilAnalysisSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  SoilAnalysisResultScreen(soilAnalysisModel: state.result),
            ),
          );
        }
        if (state is SoilAnalysisError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
        }
      },

      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Custom AppBar / Header
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.black,
                              size: 20,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Soil Analysis',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 48,
                        ), // Balance for centering title
                      ],
                    ),

                    const SizedBox(height: 32),

                    const Text(
                      'Enter Soil Data',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryBrown,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Provide the metrics below for an accurate analysis and tailored recommendations.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 32),
                    _buildInputSection(
                      '(EC)',
                      'e.g., 1.5 dS/m',
                      ec,
                      TextInputType.number,
                      _validateNumber,
                    ),
                    _buildInputSection(
                      '(SAR)',
                      'e.g., 10',
                      sar,
                      TextInputType.number,
                      _validateNumber,
                    ),
                    _buildInputSection(
                      '(CaCO3)',
                      'e.g., 5%',
                      caco3,
                      TextInputType.number,
                      _validateNumber,
                    ),
                    _buildInputSection(
                      '(Gypsum)',
                      'e.g., 2%',
                      gypsum,
                      TextInputType.number,
                      _validateNumber,
                    ),
                    _buildInputSection(
                      '(OM)',
                      'e.g., 3%',
                      om,
                      TextInputType.number,
                      _validateNumber,
                    ),
                    _buildInputSection(
                      '(N)',
                      'e.g., 0.2%',
                      n,
                      TextInputType.number,
                      _validateNumber,
                    ),
                    _buildInputSection(
                      '(P)',
                      'e.g., 15 ppm',
                      p,
                      TextInputType.number,
                      _validateNumber,
                    ),
                    _buildInputSection(
                      '(K)',
                      'e.g., 200 ppm',
                      k,
                      TextInputType.number,
                      _validateNumber,
                    ),
                    _buildInputSection(
                      '(Fe)',
                      'e.g., 50 ppm',
                      fe,
                      TextInputType.number,
                      _validateNumber,
                    ),
                    _buildInputSection(
                      '(Mn)',
                      'e.g., 20 ppm',
                      mn,
                      TextInputType.number,
                      _validateNumber,
                    ),
                    _buildInputSection(
                      '(Zn)',
                      'e.g., 10 ppm',
                      zn,
                      TextInputType.number,
                      _validateNumber,
                    ),
                    _buildInputSection(
                      '(Cu)',
                      'e.g., 5 ppm',
                      cu,
                      TextInputType.number,
                      _validateNumber,
                    ),
                    _buildInputSection(
                      '(Effective Depth)',
                      'e.g., 30 cm',
                      e_depth,
                      TextInputType.number,
                      (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "This field is required";
                        }

                        if (int.tryParse(value) == null) {
                          return "Enter a valid number";
                        }

                        return null;
                      },
                    ),
                    _buildInputSection(
                      '(pH)',
                      'e.g., 6.5',
                      ph,
                      TextInputType.number,
                      _validateNumber,
                    ),
                    _buildInputSection(
                      '(Texture)',
                      'e.g., Loamy',
                      texture,
                      TextInputType.text,
                      (value) {
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please fill all fields correctly"),
                            ),
                          );
                          return;
                        }

                        context.read<SoilAnalysisCubit>().predictSoilQuality(
                          ec: double.parse(ec.text.trim()),
                          sar: double.parse(sar.text.trim()),
                          caco3: double.parse(caco3.text),
                          gypsum: double.parse(gypsum.text),
                          om: double.parse(om.text),
                          n: double.parse(n.text),
                          p: double.parse(p.text),
                          k: double.parse(k.text),
                          fe: double.parse(fe.text),
                          mn: double.parse(mn.text),
                          zn: double.parse(zn.text),
                          cu: double.parse(cu.text),
                          eDepth: int.parse(e_depth.text),
                          ph: double.parse(ph.text),
                          texture: texture.text.trim(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryBrown,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Analyze Soil',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputSection(
    String label,
    String hint,
    TextEditingController controller,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryBrown,
            ),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            hintText: hint,
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
            validator: validator,
          ),
        ],
      ),
    );
  }

  String? _validateNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required";
    }

    if (double.tryParse(value) == null) {
      return "Enter a valid number";
    }

    return null;
  }
}
