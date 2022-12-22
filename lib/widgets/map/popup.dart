import 'package:flutter/material.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:partirecept/models/marker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

class MapPopup extends StatefulWidget {
  final Marker marker;
  MapPopup(this.marker, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapPopupState(marker);
}

class _MapPopupState extends State<MapPopup> {
  // ignore: unused_field
  final Marker _marker;

  final List<IconData> _icons = [Icons.copy, Icons.check];
  int _currentIcon = 0;

  _MapPopupState(this._marker);

  formatURL(String url) {
    return new RichText(
      text: new TextSpan(
        children: [
          new TextSpan(text: 'Website: ', style: new TextStyle(fontSize: 12.0)),
          new TextSpan(
            text: '${url}',
            style: new TextStyle(color: Colors.blue, fontSize: 12.0),
            recognizer: new TapGestureRecognizer()
              ..onTap = () {
                launch('${url}');
              },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: secondaryYellow,
      child: InkWell(
        onTap: () => setState(() {
          Clipboard.setData(new ClipboardData(text: '${this._marker.name}'))
              .then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Address copied to clipboard")));
          });
          if (_currentIcon == 0) {
            _currentIcon = 1;
          }
        }),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: _currentIcon == 0
                  ? Icon(_icons[_currentIcon])
                  : OverflowBar(
                      children: [
                        Text("Copied!"),
                        Icon(_icons[_currentIcon], color: Colors.white)
                      ],
                    ),
            ),
            _cardDescription(context),
          ],
        ),
      ),
    );
  }

  Widget _cardDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '${this._marker.name}',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              this._marker.type.length > 0 ? '${this._marker.type}' : "",
              style: const TextStyle(fontSize: 12.0),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              'Description: ${this._marker.description}',
              style: const TextStyle(fontSize: 12.0),
            ),
            Text(
              'Address: ${this._marker.address}',
              style: const TextStyle(fontSize: 12.0),
            ),
            new InkWell(
                child: this._marker.contact.length > 0
                    ? formatURL((this._marker.contact))
                    : new Text(
                        "Website: N/A",
                        style: const TextStyle(fontSize: 12.0),
                      ),
                onTap: () => launch('${this._marker.contact}')),
          ],
        ),
      ),
    );
  }
}
