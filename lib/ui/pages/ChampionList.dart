import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:valorant/business_logic/bloc/champion/champions_cubit.dart';
import 'package:valorant/ui/pages/ChampionDetail.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChampionList extends StatefulWidget {
  const ChampionList({Key? key}) : super(key: key);

  @override
  State<ChampionList> createState() => _ChampionListState();
}

class _ChampionListState extends State<ChampionList> {

  TextEditingController _controller = TextEditingController();

  final category = <String>[];

  var selected = "";
  var text = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ChampionsCubit>(context).getChampions();

    category.add("all");
    category.add("initiator");
    category.add("duelist");
    category.add("sentinel");
    category.add("controller");

    setState(() {
      selected = category[0];
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
        appBar: AppBar(
          toolbarHeight: 100,
          leading: InkWell(child: Icon(Icons.arrow_back_ios_new), onTap: () => Navigator.of(context).pop(),),
          title: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 30, right: 60),
              child: SvgPicture.asset(
                "./assets/valorant-logo.svg",
                width: 70,
                height: 70,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _controller,
                        onChanged: (String value){
                          setState(() {
                            text = value;
                          });
                          BlocProvider.of<ChampionsCubit>(context).getChampions(text: value, category: selected);
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),),
                          hintStyle: TextStyle(color: Colors.white70),
                          hintText: 'Type here...',
                        ),
                      ),
                    ),
                  ),
                  DropdownButton<String>(
                    style: const TextStyle(color: Colors.white),
                    dropdownColor: Colors.black,
                    value: selected,
                      items: category.map<DropdownMenuItem<String>>((String e) {
                        return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                        );
                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          selected = value!;
                          BlocProvider.of<ChampionsCubit>(context).getChampions(text: text, category: value);
                        });
                      }
                  )
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<ChampionsCubit, ChampionsState>(
                builder: (context, state) {
                  if (state is SuccessChampionsState) {
                    return GridView.builder(
                      itemCount: state.championsResponse!.data!.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 230,
                          mainAxisSpacing: 40),
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChampionDetail(
                                    champ: state.championsResponse!.data![index]),
                              ),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.topCenter,
                            fit: StackFit.passthrough,
                            children: [
                              SvgPicture.asset(
                                'assets/champ-container.svg',
                                width: 160,
                                height: 130,
                                color: Color(int.parse(
                                    "0xFF${state.championsResponse!.data![index]!.backgroundGradientColors![1].toString().substring(0, 6)}")),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      child: CachedNetworkImage(
                                    imageUrl: state.championsResponse!.data![index]!.bustPortrait ?? "",
                                  )),
                                  Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Text(
                                        "${state.championsResponse!.data![index]!.displayName}"
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            color: Color.fromARGB(255, 30, 30, 30),
                                            fontFamily: 'monument',
                                            fontSize: 22),
                                      )
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                  else if(state is LoadingChampionsState){
                    return const Center(
                      child: CircularProgressIndicator(color: Color.fromARGB(255,235, 86, 91),),
                    );
                  }
                  else{
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        const Icon(Icons.dangerous_outlined, color: Color.fromARGB(255,235, 86, 91), size: 60,),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const Text("Something was wrong, check your internet connection",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'monument',
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        )
    );
  }
}
