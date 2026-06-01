import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'Gharsa'**
  String get appName;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAccount;

  /// No description provided for @secureLogin.
  ///
  /// In en, this message translates to:
  /// **'Securely login to your account'**
  String get secureLogin;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @reWritePassword.
  ///
  /// In en, this message translates to:
  /// **'Re-write Password'**
  String get reWritePassword;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @latestAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Latest Analysis'**
  String get latestAnalysis;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @soilAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Soil Analysis'**
  String get soilAnalysis;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @joined.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get joined;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @na.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get na;

  /// No description provided for @soilIntelligenceAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Soil Intelligence Analysis'**
  String get soilIntelligenceAnalysis;

  /// No description provided for @enterSoilParameters.
  ///
  /// In en, this message translates to:
  /// **'Enter soil parameters for AI-powered agricultural insights'**
  String get enterSoilParameters;

  /// No description provided for @soilChemistry.
  ///
  /// In en, this message translates to:
  /// **'Soil Chemistry'**
  String get soilChemistry;

  /// No description provided for @ec.
  ///
  /// In en, this message translates to:
  /// **'EC'**
  String get ec;

  /// No description provided for @sar.
  ///
  /// In en, this message translates to:
  /// **'SAR'**
  String get sar;

  /// No description provided for @caco3.
  ///
  /// In en, this message translates to:
  /// **'CaCO3'**
  String get caco3;

  /// No description provided for @gypsum.
  ///
  /// In en, this message translates to:
  /// **'Gypsum'**
  String get gypsum;

  /// No description provided for @organicMatter.
  ///
  /// In en, this message translates to:
  /// **'Organic Matter (OM)'**
  String get organicMatter;

  /// No description provided for @macroNutrients.
  ///
  /// In en, this message translates to:
  /// **'Macro Nutrients'**
  String get macroNutrients;

  /// No description provided for @nitrogen.
  ///
  /// In en, this message translates to:
  /// **'Nitrogen (N)'**
  String get nitrogen;

  /// No description provided for @phosphorus.
  ///
  /// In en, this message translates to:
  /// **'Phosphorus (P)'**
  String get phosphorus;

  /// No description provided for @potassium.
  ///
  /// In en, this message translates to:
  /// **'Potassium (K)'**
  String get potassium;

  /// No description provided for @microNutrients.
  ///
  /// In en, this message translates to:
  /// **'Micro Nutrients'**
  String get microNutrients;

  /// No description provided for @iron.
  ///
  /// In en, this message translates to:
  /// **'Iron (Fe)'**
  String get iron;

  /// No description provided for @manganese.
  ///
  /// In en, this message translates to:
  /// **'Manganese (Mn)'**
  String get manganese;

  /// No description provided for @zinc.
  ///
  /// In en, this message translates to:
  /// **'Zinc (Zn)'**
  String get zinc;

  /// No description provided for @copper.
  ///
  /// In en, this message translates to:
  /// **'Copper (Cu)'**
  String get copper;

  /// No description provided for @physicalProperties.
  ///
  /// In en, this message translates to:
  /// **'Physical Properties'**
  String get physicalProperties;

  /// No description provided for @effectiveDepth.
  ///
  /// In en, this message translates to:
  /// **'Effective Depth'**
  String get effectiveDepth;

  /// No description provided for @ph.
  ///
  /// In en, this message translates to:
  /// **'pH'**
  String get ph;

  /// No description provided for @soilTexture.
  ///
  /// In en, this message translates to:
  /// **'Soil Texture'**
  String get soilTexture;

  /// No description provided for @clay.
  ///
  /// In en, this message translates to:
  /// **'Clay'**
  String get clay;

  /// No description provided for @clayLoam.
  ///
  /// In en, this message translates to:
  /// **'Clay Loam'**
  String get clayLoam;

  /// No description provided for @loam.
  ///
  /// In en, this message translates to:
  /// **'Loam'**
  String get loam;

  /// No description provided for @loamySand.
  ///
  /// In en, this message translates to:
  /// **'Loamy Sand'**
  String get loamySand;

  /// No description provided for @sand.
  ///
  /// In en, this message translates to:
  /// **'Sand'**
  String get sand;

  /// No description provided for @sandyClay.
  ///
  /// In en, this message translates to:
  /// **'Sandy Clay'**
  String get sandyClay;

  /// No description provided for @sandyClayLoam.
  ///
  /// In en, this message translates to:
  /// **'Sandy Clay Loam'**
  String get sandyClayLoam;

  /// No description provided for @sandyLoam.
  ///
  /// In en, this message translates to:
  /// **'Sandy Loam'**
  String get sandyLoam;

  /// No description provided for @siltyClay.
  ///
  /// In en, this message translates to:
  /// **'Silty Clay'**
  String get siltyClay;

  /// No description provided for @siltyClayLoam.
  ///
  /// In en, this message translates to:
  /// **'Silty Clay Loam'**
  String get siltyClayLoam;

  /// No description provided for @siltyLoam.
  ///
  /// In en, this message translates to:
  /// **'Silty Loam'**
  String get siltyLoam;

  /// No description provided for @analyzeSoil.
  ///
  /// In en, this message translates to:
  /// **'Analyze Soil'**
  String get analyzeSoil;

  /// No description provided for @analysisDetails.
  ///
  /// In en, this message translates to:
  /// **'Analysis Details'**
  String get analysisDetails;

  /// No description provided for @soilInput.
  ///
  /// In en, this message translates to:
  /// **'Soil Input'**
  String get soilInput;

  /// No description provided for @result.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get result;

  /// No description provided for @soilLevel.
  ///
  /// In en, this message translates to:
  /// **'Soil Level'**
  String get soilLevel;

  /// No description provided for @soilColor.
  ///
  /// In en, this message translates to:
  /// **'Soil Color'**
  String get soilColor;

  /// No description provided for @nameEn.
  ///
  /// In en, this message translates to:
  /// **'Name EN'**
  String get nameEn;

  /// No description provided for @recommendedCrops.
  ///
  /// In en, this message translates to:
  /// **'Recommended Crops'**
  String get recommendedCrops;

  /// No description provided for @soilClassification.
  ///
  /// In en, this message translates to:
  /// **'Soil Classification'**
  String get soilClassification;

  /// No description provided for @highAgriculturalPerformance.
  ///
  /// In en, this message translates to:
  /// **'High Agricultural Performance'**
  String get highAgriculturalPerformance;

  /// No description provided for @expertSoilReport.
  ///
  /// In en, this message translates to:
  /// **'Expert Soil Report'**
  String get expertSoilReport;

  /// No description provided for @executiveSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Executive Summary & Cluster Interpretation'**
  String get executiveSummaryTitle;

  /// No description provided for @soilReportDescription.
  ///
  /// In en, this message translates to:
  /// **'The predicted soil quality cluster indicates that this soil belongs to the high agricultural performance category, suggestin...'**
  String get soilReportDescription;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMore;

  /// No description provided for @cropRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Crop Recommendation'**
  String get cropRecommendation;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @cropRecommendationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Crop Recommendations'**
  String get cropRecommendationsTitle;

  /// No description provided for @season.
  ///
  /// In en, this message translates to:
  /// **'Season'**
  String get season;

  /// No description provided for @summer.
  ///
  /// In en, this message translates to:
  /// **'Summer'**
  String get summer;

  /// No description provided for @winter.
  ///
  /// In en, this message translates to:
  /// **'Winter'**
  String get winter;

  /// No description provided for @sugarcane.
  ///
  /// In en, this message translates to:
  /// **'Sugarcane'**
  String get sugarcane;

  /// No description provided for @maize.
  ///
  /// In en, this message translates to:
  /// **'Maize'**
  String get maize;

  /// No description provided for @rice.
  ///
  /// In en, this message translates to:
  /// **'Rice'**
  String get rice;

  /// No description provided for @wheat.
  ///
  /// In en, this message translates to:
  /// **'Wheat'**
  String get wheat;

  /// No description provided for @sugarcaneSupport.
  ///
  /// In en, this message translates to:
  /// **'High organic matter and suitable pH support sugarcane growth'**
  String get sugarcaneSupport;

  /// No description provided for @maizeSupport.
  ///
  /// In en, this message translates to:
  /// **'Moderate nitrogen and phosphorus levels support maize growth'**
  String get maizeSupport;

  /// No description provided for @riceSupport.
  ///
  /// In en, this message translates to:
  /// **'High potassium levels and suitable pH support rice growth'**
  String get riceSupport;

  /// No description provided for @analyzingSoil.
  ///
  /// In en, this message translates to:
  /// **'Analyzing soil...'**
  String get analyzingSoil;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredField;

  /// No description provided for @enterValidNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get enterValidNumber;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @changeAppLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change App Language'**
  String get changeAppLanguage;

  /// No description provided for @choseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Chose Language'**
  String get choseLanguage;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get version;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
