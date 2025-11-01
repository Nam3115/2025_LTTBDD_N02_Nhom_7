import 'package:flutter/material.dart';
import '../data/vietnam_locations.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  String? _selectedCity; // Thành phố đang được chọn
  List<String> _filteredItems = [];
  bool _showingSubLocations = false;

  @override
  void initState() {
    super.initState();
    _filteredItems = [...popularCities, ...internationalCities];
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        if (_showingSubLocations && _selectedCity != null) {
          // Đang ở màn hình phường/quận
          _filteredItems = vietnamLocations[_selectedCity] ?? [];
        } else {
          // Đang ở màn hình chính
          _filteredItems = [...popularCities, ...internationalCities];
        }
      } else {
        if (_showingSubLocations && _selectedCity != null) {
          // Tìm trong danh sách phường/quận
          final subLocs = vietnamLocations[_selectedCity] ?? [];
          _filteredItems = subLocs
              .where((loc) => loc.toLowerCase().contains(query.toLowerCase()))
              .toList();
        } else {
          // Tìm trong danh sách thành phố
          final allCities = [...popularCities, ...internationalCities];
          _filteredItems = allCities
              .where((city) => city.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      }
    });
  }

  void _onCityTap(String city) {
    // Kiểm tra xem city này có danh sách phường/quận không
    if (vietnamLocations.containsKey(city)) {
      setState(() {
        _selectedCity = city;
        _showingSubLocations = true;
        _filteredItems = vietnamLocations[city] ?? [];
        _searchController.clear();
      });
    } else {
      // Không có sub-locations, trả về thành phố
      Navigator.pop(context, city);
    }
  }

  void _onSubLocationTap(String subLocation) {
    // Trả về địa chỉ đầy đủ: "Quận, Thành phố"
    final fullLocation = '$subLocation, $_selectedCity';
    Navigator.pop(context, fullLocation);
  }

  void _onBackPressed() {
    if (_showingSubLocations) {
      // Quay lại danh sách thành phố
      setState(() {
        _showingSubLocations = false;
        _selectedCity = null;
        _filteredItems = [...popularCities, ...internationalCities];
        _searchController.clear();
      });
    } else {
      // Thoát khỏi màn hình
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onBackPressed();
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF4A90E2), Color(0xFF50C9C3)],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: _onBackPressed,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            controller: _searchController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: _showingSubLocations
                                  ? 'Tìm quận/huyện trong $_selectedCity...'
                                  : 'Tìm kiếm thành phố...',
                              hintStyle: const TextStyle(color: Colors.white70),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.white70,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                            ),
                            onChanged: _filterItems,
                            onSubmitted: (value) {
                              if (value.isNotEmpty) {
                                if (_showingSubLocations) {
                                  _onSubLocationTap(value);
                                } else {
                                  _onCityTap(value);
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Breadcrumb khi đang xem sub-locations
                if (_showingSubLocations && _selectedCity != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white70,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _selectedCity!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.chevron_right,
                          color: Colors.white70,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Chọn quận/huyện',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      final isCity = !_showingSubLocations;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: ListTile(
                          leading: Icon(
                            isCity ? Icons.location_city : Icons.place,
                            color: Colors.white,
                          ),
                          title: Text(
                            item,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Icon(
                            isCity && vietnamLocations.containsKey(item)
                                ? Icons
                                      .chevron_right // Có sub-locations
                                : Icons
                                      .arrow_forward_ios, // Không có sub-locations
                            color: Colors.white70,
                            size: 16,
                          ),
                          onTap: () {
                            if (_showingSubLocations) {
                              _onSubLocationTap(item);
                            } else {
                              _onCityTap(item);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
