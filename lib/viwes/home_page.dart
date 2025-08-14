import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/controller/home_controller.dart';

import '../controller/lang_controller.dart';
import '../generated/l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HomeController>();
    final lang = S.of(context);
    final langController = context.read<LocaleController>();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF74b9ff), Color(0xFF0984e3), Color(0xFF6c5ce7)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Header with location
                _buildHeader(context,  langController),

                const SizedBox(height: 30),

                // Main weather card
                Consumer<HomeController>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                              SizedBox(height: 20),
                              Text(
                                lang.gettingWeatherData,
                                style: GoogleFonts.poppins(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (provider.errorMessage.isNotEmpty) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.triangleExclamation,
                                color: Colors.white70,
                                size: 50,
                              ),
                              SizedBox(height: 20),
                              Text(
                                lang.oops,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Text(
                                  provider.errorMessage,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () => provider.refreshWeatherData(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withValues(
                                    alpha: 0.2,
                                  ),
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                child: Text(
                                  lang.tryAgain,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildMainWeatherCard(provider , context),
                            const SizedBox(height: 20),
                            _buildWeatherDetailsGrid(provider,context),
                            const SizedBox(height: 20),
                            _buildSunTimesCard(provider, context),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Bottom navigation
                _buildBottomNavigation(controller, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context ,LocaleController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).weather,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              S.of(context).today,
              style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(

              borderRadius: BorderRadius.circular(19),
              value: controller.currentLang,
              dropdownColor: const Color(0xFF74b9ff),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 20),
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              items: [
                DropdownMenuItem<String>(
                  value: 'ar',
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 16,
                        width: 16,
                        child: SvgPicture.asset("assets/svg/tn.svg"),
                      ),
                      const SizedBox(width: 8),
                      Text("Ar"),
                    ],
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'en',
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 16,
                        width: 16,
                        child: SvgPicture.asset("assets/svg/united-kingdom-flag-icon.svg"),
                      ),
                      const SizedBox(width: 8),
                      Text("En"),
                    ],
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'fr',
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 16,
                        width: 16,
                        child: SvgPicture.asset("assets/svg/flag-for-flag-france-svgrepo-com.svg"),
                      ),
                      const SizedBox(width: 8),
                      Text("Fr"),
                    ],
                  ),
                ),
              ],
              onChanged: (value) async{
                 controller.changeLang(value?? "ar");
                controller.refrechScreen();

              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainWeatherCard(provider , context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.3),
            Colors.white.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Location
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.locationDot, color: Colors.white, size: 16),
              SizedBox(width: 8),
              Text(
                '${provider.currentWeather.name ?? 'Mahdia'}, ${provider.currentWeather.sys?.country ?? 'TN'}',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          // Weather icon
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(60),
            ),
            child: Center(
              child: Image.network(
                // make Image Url
                '',
                height: 80,
                width: 80,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    FontAwesomeIcons.sun,
                    color: Colors.white,
                    size: 50,
                  );
                },
              ),
            ),
          ),

          SizedBox(height: 15),

          // Weather description
          Text(
            provider.currentWeather.weather?[0]?.description?.toUpperCase() ??
                S.of(context).clearSky,
              style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
            ),
          ),

          SizedBox(height: 10),

          // Temperature
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${provider.currentWeather.main?.temp?.round() ?? 25}',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 72,
                  fontWeight: FontWeight.w200,
                ),
              ),
              Text(
                '°C',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),

          // Feels like temperature
          Text(
            '${S.of(context).feelsLike(provider.currentWeather.main?.feelsLike?.round() ?? 26) } ',
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetailsGrid(provider, BuildContext context) {
    final lang = S.of(context);
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 1.1,
      children: [
        _buildDetailCard(
          icon: FontAwesomeIcons.temperatureHigh,
          title: lang.maxTemp,
          value: '${provider.currentWeather.main?.tempMax?.round() ?? 25}°C',
          color: Color(0xFFff7675),
        ),
        _buildDetailCard(
          icon: FontAwesomeIcons.temperatureLow,
          title: lang.minTemp,
          value: '${provider.currentWeather.main?.tempMin?.round() ?? 25}°C',
          color: Color(0xFF74b9ff),
        ),
        _buildDetailCard(
          icon: FontAwesomeIcons.droplet,
          title: lang.humidity,
          value: '${provider.currentWeather.main?.humidity ?? 76}%',
          color: Color(0xFF00b894),
        ),
        _buildDetailCard(
          icon: FontAwesomeIcons.wind,
          title: lang.windSpeed,
          value: '${provider.currentWeather.wind?.speed ?? 1.13} m/s',
          color: Color(0xFF6c5ce7),
        ),
      ],
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.25),
            Colors.white.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSunTimesCard(provider, BuildContext context) {
    final lang = S.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.25),
            Colors.white.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSunTimeItem(
            icon: FontAwesomeIcons.solidSun,
            title: lang.sunrise,
            time: _formatTime(provider.currentWeather.sys?.sunrise) ?? '06:15',
            color: Color(0xFFfdcb6e),
          ),
          Container(
            height: 50,
            width: 1,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          _buildSunTimeItem(
            icon: FontAwesomeIcons.moon,
            title: lang.sunset,
            time: _formatTime(provider.currentWeather.sys?.sunset) ?? '19:45',
            color: Color(0xFFe17055),
          ),
        ],
      ),
    );
  }

  Widget _buildSunTimeItem({
    required IconData icon,
    required String title,
    required String time,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        Text(
          time,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation(controller, context) {

    return Container(
      height: 70,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.3),
            Colors.white.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            icon: FontAwesomeIcons.locationDot,
            isActive: true,
            onTap: () async {
              await controller.refreshWeatherData();
            },
          ),
          _buildNavItem(
            icon: FontAwesomeIcons.magnifyingGlass,
            onTap: () => _showSearchDialog(context, controller),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: isActive
            ? BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(25),
              )
            : null,
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }

  void _showSearchDialog(BuildContext context, HomeController controller) {
    TextEditingController searchController = TextEditingController();
    showDialog(
      context: context,

      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF74b9ff).withValues(alpha: 0.95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            S.of(context).searchCity,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: searchController,
            style: GoogleFonts.poppins(color: Colors.white),
            decoration: InputDecoration(
              hintText: S.of(context).enterCityName,
              hintStyle: GoogleFonts.poppins(color: Colors.white70),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            autofocus: true,
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                Navigator.of(context).pop();
                controller.fetchWeatherForCity(value.trim());
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
               S.of(context).cancel,
                style: GoogleFonts.poppins(color: Colors.white70),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (searchController.text.trim().isNotEmpty) {
                  Navigator.of(context).pop();
                  controller.fetchWeatherForCity(searchController.text.trim());
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Color(0xFF74b9ff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                S.of(context).search,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  String? _formatTime(int? timestamp) {
    if (timestamp == null) return null;
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
