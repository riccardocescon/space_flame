import 'package:flutter/material.dart';
import 'package:space_flame/utils/navigation.dart';
import 'package:space_flame/utils/sprite_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.lightBlue,
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.menu,
                  size: 40,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          menuTitle("SPACE GAME"),
          /* MaterialButton(
            onPressed: () => Navigator.pushNamed(context, Navigation.gamepage),
            child: const Text("Start Game"),
          ), */
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: AspectRatio(
              aspectRatio: 10 / 11,
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, Navigation.gamepage),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Hero(
                      tag: "map",
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: const Color.fromARGB(255, 2, 0, 23),
                          border: Border.all(
                            color: Colors.white,
                            width: 13,
                          ),
                        ),
                      ),
                    ),
                    Hero(
                      tag: "ship",
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset(
                          SpriteHelper.spritePath + SpriteHelper.ship,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  splashRadius: 20,
                  icon: const Icon(Icons.settings, color: Colors.white),
                ),
                const SizedBox(
                  width: 15,
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Text(
                    "CREDITS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.lightBlue.shade100,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget menuTitle(String title) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.lightBlue.shade100,
          fontWeight: FontWeight.w600,
          fontSize: 40,
        ),
      ),
    );
  }
}
