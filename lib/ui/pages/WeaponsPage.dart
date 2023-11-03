import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valorant/business_logic/bloc/weapon/weapon_cubit.dart';
import 'package:valorant/ui/components/ErrorComponent.dart';

class WeaponsPage extends StatefulWidget {
  const WeaponsPage({super.key});

  @override
  State<WeaponsPage> createState() => _WeaponsPageState();
}

class _WeaponsPageState extends State<WeaponsPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeaponCubit>(context).getWeapons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: const Color.fromARGB(255, 38, 38, 38),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
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
      body: BlocBuilder<WeaponCubit, WeaponState>(
        builder: (context, state){
          if(state is WeaponsLoading){
            return Center(child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),);
          } else if(state is WeaponsSuccess){

            var weapons = state.response.data;

            return ListView.builder(
                itemCount: weapons?.length,
                itemBuilder: (BuildContext context, index) {
                  return InkWell(
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.only(
                            left: 40, bottom: 10, top: 20, right: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 160,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 45, 45, 45),
                            image: DecorationImage(
                                alignment: const Alignment(0.8, 0),
                                scale: 2.4,
                                image: NetworkImage(
                                  weapons?[index].displayIcon ?? "",
                                ))),
                        child: Text(
                          weapons![index].displayName.toUpperCase(),
                          style: const TextStyle(
                            fontFamily: 'monument',
                            fontSize: 26,
                            color: Colors.white,
                          ),
                        )),
                    onTap: () {
                      BlocProvider.of<WeaponCubit>(context).setWeapon(weapons[index]);
                      context.push('/weapon-detail');
                    },
                  );
                });
          } else{
              return const ErrorComponent();
          }

        },
      )
    );
  }
}
