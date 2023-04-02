// 必要パッケージのインストール
import "package:flutter/material.dart";
import 'package:webfeed/domain/media/thumbnail.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RSS extends StatefulWidget {
  const RSS({super.key});

  final String title = 'RSS Feed';

  @override
  State<RSS> createState() => _RSSState();
}

class _RSSState extends State<RSS> {
  static const String FEED_URL =
      "https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss";
  late RssFeed _feed;
  late String _title;
  static const String loadingFeedMsg = "Loading Feed...";
  static const String feedLoadErrordMsg = "Error Loading Feed...";
  static const String placeholderImg = "images/no_image.png";
  late GlobalKey<RefreshIndicatorState> _refreshKey;

  // タイトルを更新する
  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  // タイトルを更新する
  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  load() async {
    updateTitle(loadingFeedMsg);
    loadFeed().then((result) {
      if (null == result || result.toString().toString().isEmpty) {
        updateTitle(feedLoadErrordMsg);
        return;
      }
      updateFeed(result);
      updateTitle(_feed.title);
    });
  }

  Future<RssFeed?> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(FEED_URL as Uri);
      return RssFeed.parse(response.body);
    } catch (e) {}
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    super.initState();
    updateTitle(widget.title);
    load();
  }

  title(title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  subtitle(subtitle) {
    return Text(
      subtitle,
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  thumbnail(imageUrl) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: CachedNetworkImage(
        placeholder: (context, url) => Image.asset(placeholderImg),
        imageUrl: imageUrl,
        height: 50,
        width: 50,
        alignment: Alignment.center,
        fit: BoxFit.fill,
      ),
    );
  }

  rightIcon() {
    return Icon(
      Icons.keyboard_arrow_right,
      color: Colors.grey,
      size: 30,
    );
  }

  list() {
    return ListView.builder(
      itemCount: _feed.items?.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _feed.items![index];
        return ListTile(
          title: title(item.title),
          subtitle: subtitle(item.pubDate),
          leading: thumbnail(item.enclosure?.url),
          trailing: rightIcon(),
          contentPadding: EdgeInsets.all(5.0),
          onTap: () {},
        );
      },
    );
  }

  isFeedEmpty() {
    return null == _feed || null == _feed.items;
  }

  body() {
    return isFeedEmpty()
        ? Center(
            child: CircularProgressIndicator(),
          )
        : list();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: body(),
    );
  }
}
