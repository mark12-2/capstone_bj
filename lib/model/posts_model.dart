class Post {
  String? id;
  String? title;
  String? description;
  String? type;
  String? location;
  String? rate;
  String? ownerId;
  // List<Comment>? comments;

  Post({
    this.id,
    this.title,
    this.description,
    this.type,
    this.location,
    this.rate,
    this.ownerId,
    // this.comments,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    // final comments = map['comments'] as List<dynamic>;
    // final commentList = comments.map((comment) => Comment.fromMap(comment)).toList();
    return Post(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      type: map['type'],
      location: map['location'],
      rate: map['rate'],
      ownerId: map['ownerId'],
      // comments: commentList,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'type': type,
      'location': location,
      'rate': rate,
    };
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