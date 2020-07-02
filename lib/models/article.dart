// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);

import 'dart:convert';
import 'package:Toot/models/user.dart';

List<Article> articleFromJson(String str) => List<Article>.from(json.decode(str).map((x) => Article.fromJson(x)));

String articleToJson(List<Article> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Article {
    String status;
    List<Photo> photos;
    String id;
    String description;
    String content;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String hightlight;
    int price;
    int promotion;
    String tag;
    User author;
    Category category;
    Location location;
    String articleId;

    Article({
        this.status,
        this.photos,
        this.id,
        this.description,
        this.content,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.hightlight,
        this.price,
        this.promotion,
        this.tag,
        this.author,
        this.category,
        this.location,
        this.articleId,
    });

    factory Article.fromJson(Map<String, dynamic> json) => Article(
        status: json["status"] == null ? null : json["status"],
        photos: List<Photo>.from(json["Photos"].map((x) => Photo.fromJson(x))),
        id: json["_id"],
        description: json["description"],
        content: json["content"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        hightlight: json["hightlight"] == null ? null : json["hightlight"],
        price: json["price"] == null ? null : json["price"],
        promotion: json["promotion"] == null ? null : json["promotion"],
        tag: json["tag"] == null ? null : json["tag"],
        author: json["author"] == null ? null : User.fromJson(json["author"]),
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        articleId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "Photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "_id": id,
        "description": description,
        "content": content,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "hightlight": hightlight == null ? null : hightlight,
        "price": price == null ? null : price,
        "promotion": promotion == null ? null : promotion,
        "tag": tag == null ? null : tag,
        "author": author == null ? null : author.toJson(),
        "category": category == null ? null : category.toJson(),
        "location": location == null ? null : location.toJson(),
        "id": articleId,
    };
}

class Category {
    String id;
    String name;
    String subCategory;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String categoryId;

    Category({
        this.id,
        this.name,
        this.subCategory,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.categoryId,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        subCategory: json["sub_category"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        categoryId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "sub_category": subCategory,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "id": categoryId,
    };
}

class Location {
    String id;
    String nation;
    String address;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String locationId;

    Location({
        this.id,
        this.nation,
        this.address,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.locationId,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["_id"],
        nation: json["nation"],
        address: json["Address"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        locationId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nation": nation,
        "Address": address,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "id": locationId,
    };
}

class Photo {
    String id;
    String name;
    String alternativeText;
    String caption;
    String hash;
    Ext ext;
    Mime mime;
    double size;
    int width;
    int height;
    String url;
    Formats formats;
    String provider;
    List<String> related;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String photoId;

    Photo({
        this.id,
        this.name,
        this.alternativeText,
        this.caption,
        this.hash,
        this.ext,
        this.mime,
        this.size,
        this.width,
        this.height,
        this.url,
        this.formats,
        this.provider,
        this.related,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.photoId,
    });

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["_id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        hash: json["hash"],
        ext: extValues.map[json["ext"]],
        mime: mimeValues.map[json["mime"]],
        size: json["size"].toDouble(),
        width: json["width"],
        height: json["height"],
        url: json["url"],
        formats: Formats.fromJson(json["formats"]),
        provider: json["provider"],
        related: List<String>.from(json["related"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        photoId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "hash": hash,
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "size": size,
        "width": width,
        "height": height,
        "url": url,
        "formats": formats.toJson(),
        "provider": provider,
        "related": List<dynamic>.from(related.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "id": photoId,
    };
}

enum Ext { PNG }

final extValues = EnumValues({
    ".png": Ext.PNG
});

class Formats {
    Large thumbnail;
    Large large;
    Large medium;
    Large small;

    Formats({
        this.thumbnail,
        this.large,
        this.medium,
        this.small,
    });

    factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: (json["thumbnail"] != null) ? Large.fromJson(json["thumbnail"]) : null,
        large: (json["large"] != null) ? Large.fromJson(json["large"]) : null,
        medium: (json["medium"] != null) ? Large.fromJson(json["medium"]) : null,
        small: (json["small"] != null) ? Large.fromJson(json["small"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail.toJson(),
        "large": large.toJson(),
        "medium": medium.toJson(),
        "small": small.toJson(),
    };
}

class Large {
    String hash;
    Ext ext;
    Mime mime;
    int width;
    int height;
    double size;
    dynamic path;
    String url;

    Large({
        this.hash,
        this.ext,
        this.mime,
        this.width,
        this.height,
        this.size,
        this.path,
        this.url,
    });

    factory Large.fromJson(Map<String, dynamic> json) => Large(
        hash: json["hash"],
        ext: extValues.map[json["ext"]],
        mime: mimeValues.map[json["mime"]],
        width: json["width"],
        height: json["height"],
        size: json["size"].toDouble(),
        path: json["path"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "hash": hash,
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "width": width,
        "height": height,
        "size": size,
        "path": path,
        "url": url,
    };
}

enum Mime { IMAGE_PNG }

final mimeValues = EnumValues({
    "image/png": Mime.IMAGE_PNG
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
