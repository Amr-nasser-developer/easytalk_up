class LangModel{
  String  code;
  String  lang;
  LangModel({required this.lang,required this.code});
  factory LangModel.fromJson(Map<String, dynamic> json){
    return LangModel (code: json["code"],lang: json["lang"]);
  }
}