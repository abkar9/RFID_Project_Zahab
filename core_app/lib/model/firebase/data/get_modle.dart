class ModelGet {
  String almajlis; // المجلس
  String name; // الاسم
  String idNumber; // رقم الهوية
  String address; // العنوان
  String phoneNumber; // رقم الجوال
  String bookingNumber; // رقم الحجز
  String nationality; // الجنسية
  String typeOfSex; // الجنس
  ///////////////////////////
  String monaCamp; // مخيم منى
  String almajlisMona; // مجلس منى
  String mnamMona; // منام منى

//////////////////////////////////////
  String arafaCamp; // مخيم عرفة
  String almajlisarafa; // مجلس عرفة
  String mnamarafaa; // منام عرفة

///////////////////
  String tag1;
  String tag2;

  String tag3;

  ModelGet({
    this.address = '',
    this.almajlis = '',
    this.almajlisMona = '',
    this.almajlisarafa = '',
    this.arafaCamp = '',
    this.bookingNumber = '',
    this.idNumber = '',
    this.mnamMona = '',
    this.mnamarafaa = '',
    this.monaCamp = '',
    this.name = '',
    this.nationality = '',
    this.phoneNumber = '',
    this.tag1 = '',
    this.tag2 = '',
    this.tag3 = '',
    this.typeOfSex = '',
  });

  factory ModelGet.fromJson(Map<String, dynamic> json) {
    return ModelGet(
      idNumber: json['idNumber'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      almajlisMona: json['almajlisMona'],
      bookingNumber: json['bookingNumber'],
      almajlisarafa: json['almajlisarafa'],
      arafaCamp: json['arafaCamp'],
      nationality: json['nationality'],
      almajlis: json['almajlis'],
      mnamMona: json['mnamMona'],
      monaCamp: json['monaCamp'],
      typeOfSex: json['typeOfSex'],
      mnamarafaa: json['mnamarafaa'],
      tag1: json['tag1'],
      tag2: json['tag2'],
      tag3: json['tag3'],
    );
  }

  Map<String, dynamic> mapToJosn() => {
        'name': name, // الاسم
        'address': address, // العنوان
        'phoneNumber': phoneNumber, // رقم الجوال
        'almajlis': almajlis, // المجلس
        'idNumber': idNumber, // رقم الهوية
        'bookingNumber': bookingNumber, // رقم الحجز
        'nationality': nationality, // الجنسية
        'typeOfSex': typeOfSex, // الجنس
        'monaCamp': monaCamp, // مخيم منى
        'almajlisMona': almajlisMona, // مجلس منى
        'mnamMona': mnamMona, // منام منى
        'arafaCamp': arafaCamp, // مخيم عرفة
        'almajlisarafa': almajlisarafa, // مجلس عرفة
        'mnamarafaa': mnamarafaa, // منام عرفة
        'tag1': tag1,
        'tag2': tag2,
        'tag3': tag3,
      };
}
