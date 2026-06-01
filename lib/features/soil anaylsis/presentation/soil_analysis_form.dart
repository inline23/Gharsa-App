import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharsa_app/features/soil%20anaylsis/presentation/cubit/soil_analysis_cubit.dart';
import 'package:gharsa_app/features/soil%20anaylsis/presentation/soil_analysis_result_screen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_text_field.dart';
import 'package:gharsa_app/l10n/app_localizations.dart';


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

  final TextEditingController eDepth = TextEditingController();
  final TextEditingController ph = TextEditingController();


String getTextureName(BuildContext context, String texture) {
  final l10n = AppLocalizations.of(context)!;

  switch (texture) {
    case 'Clay':
      return l10n.clay;
    case 'Clay Loam':
      return l10n.clayLoam;
    case 'Loam':
      return l10n.loam;
    case 'Loamy Sand':
      return l10n.loamySand;
    case 'Sand':
      return l10n.sand;
    case 'Sandy Clay':
      return l10n.sandyClay;
    case 'Sandy Clay Loam':
      return l10n.sandyClayLoam;
    case 'Sandy Loam':
      return l10n.sandyLoam;
    case 'Silty Clay':
      return l10n.siltyClay;
    case 'Silty Clay Loam':
      return l10n.siltyClayLoam;
    case 'Silty Loam':
      return l10n.siltyLoam;
    default:
      return texture;
  }
}

  String? selectedTexture;

  final List<String> textures = [
    'Clay',
    'Clay Loam',
    'Loam',
    'Loamy Sand',
    'Sand',
    'Sandy Clay',
    'Sandy Clay Loam',
    'Sandy Loam',
    'Silty Clay',
    'Silty Clay Loam',
    'Silty Loam',
  ];

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
    eDepth.dispose();
    ph.dispose();
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
        if (state is SoilAnalysisLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)!.analyzingSoil,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: AppColors.secondaryBrown,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black87),
          ),
          backgroundColor: const Color(0xffF6F7F9),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ================= HEADER =================
                    Text(
                      AppLocalizations.of(context)!.soilIntelligenceAnalysis,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      AppLocalizations.of(context)!.enterSoilParameters,
                      style: TextStyle(color: Colors.black54),
                    ),

                    const SizedBox(height: 24),

                    /// ================= SECTION 1 =================
                    _buildSectionTitle(AppLocalizations.of(context)!.soilChemistry),
                    _card([
                     _field(AppLocalizations.of(context)!.ec, ec),
                      _field(AppLocalizations.of(context)!.sar, sar),
                      _field(AppLocalizations.of(context)!.caco3, caco3),
                      _field(AppLocalizations.of(context)!.gypsum, gypsum),
                      _field(AppLocalizations.of(context)!.organicMatter, om),
                    ]),

                    /// ================= SECTION 2 =================
                    _buildSectionTitle(AppLocalizations.of(context)!.macroNutrients),
                    _card([
                      _field(AppLocalizations.of(context)!.nitrogen, n),
                      _field(AppLocalizations.of(context)!.phosphorus, p),
                      _field(AppLocalizations.of(context)!.potassium, k),
                    ]),

                    /// ================= SECTION 3 =================
                    _buildSectionTitle(AppLocalizations.of(context)!.microNutrients),
                    _card([
                      _field(AppLocalizations.of(context)!.iron, fe),
                      _field(AppLocalizations.of(context)!.manganese, mn),
                      _field(AppLocalizations.of(context)!.zinc, zn),
                      _field(AppLocalizations.of(context)!.copper, cu),
                    ]),

                    /// ================= SECTION 4 =================
                    _buildSectionTitle(AppLocalizations.of(context)!.physicalProperties),
                    _card([
                      _field(AppLocalizations.of(context)!.effectiveDepth, eDepth),
                      _field(AppLocalizations.of(context)!.ph, ph),
                    ]),

                    const SizedBox(height: 16),

                    /// ================= TEXTURE =================
                    _buildSectionTitle(AppLocalizations.of(context)!.soilTexture),

                    const SizedBox(height: 10),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: textures.map((t) {
                        final isSelected = selectedTexture == t;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTexture = t;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.secondaryBrown
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.secondaryBrown
                                    : Colors.grey.shade300,
                              ),
                            ),
                            child: Text(
                              getTextureName(context, t),
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 30),

                    /// ================= CTA =================
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryBrown,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;

                          context.read<SoilAnalysisCubit>().predictSoilQuality(
                            ec: double.parse(ec.text),
                            sar: double.parse(sar.text),
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
                            eDepth: int.parse(eDepth.text),
                            ph: double.parse(ph.text),
                            texture: selectedTexture ?? "",
                          );
                        },
                        child:  Text(
                          AppLocalizations.of(context)!.analyzeSoil,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _card(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _field(String label, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: CustomTextField(
        controller: c,
        hintText: label,
        keyboardType: TextInputType.number,
      ),
    );
  }
}
