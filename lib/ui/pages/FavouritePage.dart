import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:valorant/business_logic/bloc/skins/skin_cubit.dart';
import 'package:valorant/data/models/skin/SkinResponse.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SkinCubit>(context).getSkinsByFavourite();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: const Color.fromARGB(255, 38, 38, 38),
        title: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 30),
            child: SvgPicture.asset(
              "./assets/valorant-logo.svg",
              width: 70,
              height: 70,
            ),
          ),
        ),
      ),
      body: BlocBuilder<SkinCubit, SkinState>(
        builder: (context, state) {
          if(state is SkinLoading){
            return const Center(
              child: CircularProgressIndicator(color: Color.fromARGB(255,235, 86, 91),),
            );
          }else if(state is SkinSuccess){
            List<Skin> skins = state.skinResponse.data;
            return ListView.builder(
                itemCount: skins.length,
                itemBuilder: (context, index){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 50,),
                      Image(image: NetworkImage(skins[index].displayIcon ?? ""), fit: BoxFit.fitWidth,),
                      const SizedBox(height: 50,),
                      Text(skins[index].displayName ?? "unknown",
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'monument',
                            fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20,),
                      InkWell(child: Icon(Icons.favorite_outlined, color: Colors.red,), onTap: () => BlocProvider.of<SkinCubit>(context).removeSkinByFavourite(state.skinResponse, state.skinResponse.data[index].uuid),)
                    ],
                  );
              },
            );
          }else{
            return Center(
              child: Column(
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
              ),
            );
          }
        },
      ),
    );
  }
}
