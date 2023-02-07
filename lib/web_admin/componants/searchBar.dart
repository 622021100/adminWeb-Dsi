import 'package:flutter/material.dart';
import 'package:web_admin/web_admin/componants/constant.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  initSearchingPost(String textEntered) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 300,

        child: TextField(
          onChanged: (textEntered) {},
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(36),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  )),
              filled: true,
              fillColor: kBlueGrayLite,
              hintText: "Search",
              hintStyle: const TextStyle(color: Colors.grey),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              )),
        ),
      ),
    );
  }
}
