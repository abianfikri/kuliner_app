import 'dart:convert';

import 'package:flutter/widgets.dart';

class KulinerModel {
  int? id;
  String? uid;
  final String namaKuliner;
  final String alamatKuliner;
  final String catatanReview;
  final String rating;
  String? gambar;
  KulinerModel({
    this.id,
    this.uid,
    required this.namaKuliner,
    required this.alamatKuliner,
    required this.catatanReview,
    required this.rating,
    this.gambar,
  });

  KulinerModel copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? uid,
    String? namaKuliner,
    String? alamatKuliner,
    String? catatanReview,
    String? rating,
    ValueGetter<String?>? gambar,
  }) {
    return KulinerModel(
      id: id != null ? id() : this.id,
      uid: uid != null ? uid() : this.uid,
      namaKuliner: namaKuliner ?? this.namaKuliner,
      alamatKuliner: alamatKuliner ?? this.alamatKuliner,
      catatanReview: catatanReview ?? this.catatanReview,
      rating: rating ?? this.rating,
      gambar: gambar != null ? gambar() : this.gambar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'namaKuliner': namaKuliner,
      'alamatKuliner': alamatKuliner,
      'catatanReview': catatanReview,
      'rating': rating,
      'gambar': gambar,
    };
  }

  factory KulinerModel.fromMap(Map<String, dynamic> map) {
    return KulinerModel(
      id: map['id']?.toInt(),
      uid: map['uid'],
      namaKuliner: map['namaKuliner'] ?? '',
      alamatKuliner: map['alamatKuliner'] ?? '',
      catatanReview: map['catatanReview'] ?? '',
      rating: map['rating'] ?? '',
      gambar: map['gambar'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KulinerModel.fromJson(String source) =>
      KulinerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'KulinerModel(id: $id, uid: $uid, namaKuliner: $namaKuliner, alamatKuliner: $alamatKuliner, catatanReview: $catatanReview, rating: $rating, gambar: $gambar)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KulinerModel &&
        other.id == id &&
        other.uid == uid &&
        other.namaKuliner == namaKuliner &&
        other.alamatKuliner == alamatKuliner &&
        other.catatanReview == catatanReview &&
        other.rating == rating &&
        other.gambar == gambar;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        namaKuliner.hashCode ^
        alamatKuliner.hashCode ^
        catatanReview.hashCode ^
        rating.hashCode ^
        gambar.hashCode;
  }
}
