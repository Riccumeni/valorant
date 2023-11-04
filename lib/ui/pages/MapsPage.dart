import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:valorant/ui/components/ErrorComponent.dart';
import 'package:valorant/ui/pages/MapDetailPage.dart';
import '../../business_logic/bloc/map/maps_cubit.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<MapsCubit>(context).getMaps();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          toolbarHeight: 70,
          leading: IconButton(
            onPressed: () {
              context.go('/');
            },
            icon:  Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.onPrimaryContainer,),
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
        body: BlocBuilder<MapsCubit, MapsState>(builder: (context, state) {
          if (state is SuccessMapsState) {
            return ListView.builder(
                itemCount: state.mapsResponse!.data!.length,
                itemBuilder: (BuildContext context, index) {
                  return InkWell(
                    onTap: () {
                      BlocProvider.of<MapsCubit>(context).setMap(state.mapsResponse!.data![index]);
                      context.push('/map-detail');
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 40),
                        width: MediaQuery.of(context).size.width,
                        height: 140,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                opacity: 0.7,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  state
                                      .mapsResponse?.data![index].listViewIcon ?? "",
                                ))),
                        child: Text(
                          state.mapsResponse!.data![index].displayName
                              .toUpperCase(),
                          style: const TextStyle(
                            fontFamily: 'monument',
                            fontSize: 26,
                            color: Colors.white,
                          ),
                        )),
                  );
                });
          } else if (state is LoadingMapsState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 235, 86, 91),
              ),
            );
          } else {
            return ErrorComponent(onRetryTapped: () => BlocProvider.of<MapsCubit>(context).getMaps(),);
          }
        }));
  }
}
