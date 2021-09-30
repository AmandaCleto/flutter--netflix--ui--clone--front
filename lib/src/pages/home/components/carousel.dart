import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';

import '../../../data/carrouselData.dart';
import '../../../data/detailedData.dart';
import '../../../data/creditData.dart';
import './bottomSheet.dart';

class Carousel extends StatefulWidget {
  final String title;
  final String imgPath;
  final String apiSubject;
  final String apiBase;
  final String language;
  final String apiKey;
  final String movieDetail;
  final int limit;
  final bool top10;

  const Carousel({
    Key? key,
    required this.title,
    required this.imgPath,
    required this.apiSubject,
    required this.apiBase,
    required this.language,
    required this.apiKey,
    required this.movieDetail,
    this.top10: false,
    this.limit: 0,
  }) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late String imgPath = '';
  late String detailedApi = '';
  late String creditApi = '';
  late String movieDetail = '';

  //Futures
  late Future<ApicarrouselData> futureSubject;
  late ApiDetailedData detailedData;
  late ApiCreditData creditData;

  @override
  void initState() {
    super.initState();
    imgPath = widget.imgPath;
    futureSubject =
        carrouselDataFetch(widget.apiSubject, widget.limit).then((value) {
      return value;
    });
  }

  fetchDetailedApi(context, {required itemId}) async {
    detailedApi =
        '${widget.apiBase}${widget.movieDetail}$itemId?${widget.apiKey}${widget.language}';
    creditApi =
        '${widget.apiBase}${widget.movieDetail}$itemId/credits?${widget.apiKey}${widget.language}';

    detailedData = await detailedDataFetch(detailedApi);
    creditData = await creditDataFetch(creditApi);

    modalBottomSheet(context, imgPath, detailedData, creditData);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          color: Colors.black,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder<ApicarrouselData>(
                future: futureSubject,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: widget.top10 ? 20.0 : 6.0),
                        child: Row(
                          children: snapshot.data!.results
                              .asMap()
                              .map((index, item) {
                                return MapEntry(
                                  index,
                                  GestureDetector(
                                    onTap: () {
                                      fetchDetailedApi(context,
                                          itemId: item['id']);
                                    },
                                    child: Container(
                                      height: 180,
                                      child: Indexer(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Indexed(
                                            index: 2,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  right: widget.top10 ? 28 : 6),
                                              width: 110,
                                              height: 160,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    '$imgPath${item['poster_path']}',
                                                  ),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                          ),
                                          index == 0
                                              ? SizedBox.shrink()
                                              : Indexed(
                                                  index: 4,
                                                  child: widget.top10
                                                      ? Positioned(
                                                          bottom: -10.0,
                                                          left: -28.0,
                                                          child: Stack(
                                                            children: [
                                                              Container(
                                                                height:
                                                                    size.height,
                                                                width: 28,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  gradient:
                                                                      LinearGradient(
                                                                    begin: Alignment
                                                                        .centerRight,
                                                                    end:
                                                                        Alignment(
                                                                      0.01,
                                                                      0.0,
                                                                    ),
                                                                    colors: [
                                                                      Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.1),
                                                                      Colors
                                                                          .black,
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : SizedBox.shrink(),
                                                ),
                                          Indexed(
                                            index: 3,
                                            child: widget.top10
                                                ? Positioned(
                                                    bottom: -10.0,
                                                    left: -16.0,
                                                    child: Stack(
                                                      children: [
                                                        Text(
                                                          (index + 1)
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 110,
                                                            letterSpacing:
                                                                -20.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            foreground: Paint()
                                                              ..style =
                                                                  PaintingStyle
                                                                      .stroke
                                                              ..strokeWidth = 4
                                                              ..color = Colors
                                                                  .grey
                                                                  .shade500,
                                                          ),
                                                        ),
                                                        Text(
                                                          (index + 1)
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 110,
                                                            letterSpacing:
                                                                -20.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xFF171717),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Text(''),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                              .values
                              .toList(),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFFE0000),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
