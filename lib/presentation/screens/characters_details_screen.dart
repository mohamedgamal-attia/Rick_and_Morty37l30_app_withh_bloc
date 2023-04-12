import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../business_logic/cubit/characters_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data/models/characters.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  Widget buildSliverAppBar(context) {
    return SliverAppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_outlined,size: 25.w,color: Colors.black,),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      expandedHeight: 460.h,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.name,
          style: TextStyle(color: MyColors.myGrey,fontSize: 25.sp),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.myWhite,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30.h,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is QuotesLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: MyColors.myWhite,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MyColors.myYellow,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width =MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(width/25, height/33, width/15, 0),
                  padding: EdgeInsets.all(8.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Species : ', character.species),
                      buildDivider(250.w),
                      characterInfo(
                          'Gender : ', character.gender),
                      buildDivider(250.w),
                      characterInfo('Status : ', character.statusIfDeadOrAlive),
                      buildDivider(250.w),

                      SizedBox(
                        height: 20.h,
                      ),
                      BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (context, state) {
                          return checkIfQuotesAreLoaded(state);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 500.h,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
