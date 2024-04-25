class RegisterModel {
  String? name;
  String? organisation;
  String? gst;
  String? email;
  String? phone;
  String? password;

  RegisterModel(
      {this.name,
        this.organisation,
        this.gst,
        this.email,
        this.phone,
        this.password});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    organisation = json['organisation'];
    gst = json['gst'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['organisation'] = organisation;
    data['gst'] = gst;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}
