class Post {
  String? title;
  String? description;
  String? type;
  String? location;
  String? rate;
  List<Comment>? comments;

  Post({
    this.title,
    this.description,
    this.type,
    this.location,
    this.rate,
    this.comments,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    final comments = map['comments'] as List<dynamic>;
    final commentList = comments.map((comment) => Comment.fromMap(comment)).toList();
    return Post(
      title: map['title'],
      description: map['description'],
      type: map['type'],
      location: map['location'],
      rate: map['rate'],
      comments: commentList,
    );
  }
}

class Comment {
  String? name;
  String? email;
  String? profilePic;
  String? comment;

  Comment({
    this.name,
    this.email,
    this.profilePic,
    this.comment,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      name: map['name'],
      email: map['email'],
      profilePic: map['profilePic'],
      comment: map['comment'],
    );
  }
}