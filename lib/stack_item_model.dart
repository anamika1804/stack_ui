import 'dart:convert';

class StackItem {
  final OpenState openState;
  final ClosedState closedState;
  final String ctaText;

  StackItem({
    required this.openState,
    required this.closedState,
    required this.ctaText,
  });

  factory StackItem.fromJson(Map<String, dynamic> json) {
    return StackItem(
      openState: OpenState.fromJson(json['open_state']),
      closedState: ClosedState.fromJson(json['closed_state']),
      ctaText: json['cta_text'],
    );
  }
}

class OpenState {
  final Body body;

  OpenState({required this.body});

  factory OpenState.fromJson(Map<String, dynamic> json) {
    return OpenState(
      body: Body.fromJson(json['body']),
    );
  }
}

class ClosedState {
  final Body body;

  ClosedState({required this.body});

  factory ClosedState.fromJson(Map<String, dynamic> json) {
    return ClosedState(
      body: Body.fromJson(json['body']),
    );
  }
}

class Body {
  final String title;
  final String subtitle;
  final CardDetails? card;
  final List<Item>? items;

  Body({
    required this.title,
    required this.subtitle,
    this.card,
    this.items,
  });

  factory Body.fromJson(Map<String, dynamic> json) {
    return Body(
      title: json['title'] ?? 'No Title',
      subtitle: json['subtitle'] ?? 'No Subtitle',
      card: json['card'] != null ? CardDetails.fromJson(json['card']) : null,
      items: json['items'] != null
          ? List<Item>.from(json['items'].map((x) => Item.fromJson(x)))
          : null,
    );
  }
}

class CardDetails {
  final String header;
  final String description;
  final int maxRange;
  final int minRange;

  CardDetails({
    required this.header,
    required this.description,
    required this.maxRange,
    required this.minRange,
  });

  factory CardDetails.fromJson(Map<String, dynamic> json) {
    return CardDetails(
      header: json['header'],
      description: json['description'],
      maxRange: json['max_range'],
      minRange: json['min_range'],
    );
  }
}

class Item {
  final String emi;
  final String duration;
  final String title;
  final String subtitle;
  final String? tag;

  Item({
    required this.emi,
    required this.duration,
    required this.title,
    required this.subtitle,
    this.tag,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      emi: json['emi'],
      duration: json['duration'],
      title: json['title'],
      subtitle: json['subtitle'],
      tag: json['tag'],
    );
  }
}
