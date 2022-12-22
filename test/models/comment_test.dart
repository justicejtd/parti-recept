import 'package:flutter_test/flutter_test.dart';
import 'package:partirecept/models/comment.dart';

void main() {
  test('Given comment When id is called Then returns comment id', () async {
    // Arrange
    final comment = Comment("1", "1", "comment text", "picture url");

    // Act
    comment.id;

    // Assert
    expect(comment.id, "1");
  });

  test('Given comment When user_id is called Then returns user_id', () async {
    // Arrange
    final comment = Comment("1", "1", "comment text", "picture url");

    // Act
    comment.user_id;

    // Assert
    expect(comment.user_id, "1");
  });

  test('Given comment When comment is called Then returns comment comment',
      () async {
    // Arrange
    final comment = Comment("1", "1", "comment text", "picture url");

    // Act
    comment.comment;

    // Assert
    expect(comment.comment, "comment text");
  });

  test('Given comment When picture url is called Then returns picture url',
      () async {
    // Arrange
    final comment = Comment("1", "1", "comment text", "picture url");

    // Act
    comment.picture;

    // Assert
    expect(comment.picture, "picture url");
  });
}
