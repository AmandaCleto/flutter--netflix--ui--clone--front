import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/durationTime.dart';
import '../../../utils/relevant.dart';

import 'components/detaieldItemAppBar.dart';

class DetailedItem extends StatefulWidget {
  final dynamic data;
  const DetailedItem({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailedItem> createState() => _DetailedItemState();
}

class _DetailedItemState extends State<DetailedItem> {
  @override
  Widget build(BuildContext context) {
    var itemDetailed = widget.data[0];
    var itemCast = widget.data[1];
    var imgPath = widget.data[2];

    var castAuthors = '';

    for (final index in itemCast.cast) {
      castAuthors += '${index['name']}, ';
    }

    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: DetaieldItemAppBar(),
      ),
      body: Container(
        color: Colors.black,
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: size.width,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        NetworkImage('$imgPath${itemDetailed.backdrop_path}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itemDetailed.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              relevantString(itemDetailed.vote_average),
                              style: TextStyle(
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              itemDetailed.release_date.substring(0, 4),
                              style: TextStyle(
                                color: Color(0xFF8D8D8D),
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset(
                              itemDetailed.adult
                                  ? 'assets/icons/range-18.svg'
                                  : 'assets/icons/range-universal.svg',
                              height: 20,
                              width: 20,
                              allowDrawingOutsideViewBox: true,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              durationToString(itemDetailed.runtime),
                              style: TextStyle(
                                color: Color(0xFF8D8D8D),
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: size.width,
                          height: 35,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.black,
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              'assets/icons/play.svg',
                              height: 14,
                              width: 14,
                              allowDrawingOutsideViewBox: true,
                            ),
                            label: const Text('Assistir'),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: size.width,
                          height: 35,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF3E3E3E),
                              onPrimary: Colors.white,
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              'assets/icons/download.svg',
                              height: 16,
                              width: 16,
                              allowDrawingOutsideViewBox: true,
                            ),
                            label: const Text('Download'),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          itemDetailed.overview,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Container(
                            width: size.width,
                            child: Wrap(
                              children: [
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text: 'Estrelando: ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      height: 1.2,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: castAuthors,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'mais',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    height: 1.2,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/add.svg',
                                  height: 20,
                                  width: 20,
                                  allowDrawingOutsideViewBox: true,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Minha Lista',
                                  style: TextStyle(
                                    color: Color(0xFF8D8D8D),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/like.svg',
                                  height: 20,
                                  width: 20,
                                  allowDrawingOutsideViewBox: true,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Classifique',
                                  style: TextStyle(
                                    color: Color(0xFF8D8D8D),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/share.svg',
                                  height: 20,
                                  width: 20,
                                  allowDrawingOutsideViewBox: true,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Compartilhe',
                                  style: TextStyle(
                                    color: Color(0xFF8D8D8D),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}