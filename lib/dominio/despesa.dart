class Despesa {
  int id;
  DateTime data;
  int valor;
  String descricao;
  String pago;

  Despesa();
  Despesa.initId(this.id);
  Despesa.initAll(this.id, this.data, this.valor, this.descricao, this.pago);

  Map<String, dynamic> toJson() => {
        'id': id,
        'data': data,
        'valor': valor,
        'descricao': descricao,
        'pago': pago
      };

  factory Despesa.fromJson(Map<String, dynamic> json) {
    return Despesa.initAll(json['_id'], json['data'], json['valor'],
        json['descricao'], json['pago']);
  }

  Despesa.fromMap(Map map) {
    id = map["idCol"];
    data = map["dataCol"];
    valor = map["valorCol"];
    descricao = map["descricaoCol"];
    pago = map["pagoCol"];
  }
  Map toMap() {
    Map<String, dynamic> map = {
      "idCol": id,
      "dataCol": data,
      "valorCol": valor,
      "descricaoCol": descricao,
      "pagoCol": pago,
    };
    return map;
  }
}
