class Receita {
  int id;
  DateTime data;
  int valor;
  String descricao;
  String recebido;

  Receita();
  Receita.initId(this.id);
  Receita.initAll(
      this.id, this.data, this.valor, this.descricao, this.recebido);

  Map<String, dynamic> toJson() => {
        'id': id,
        'data': data,
        'valor': valor,
        'descricao': descricao,
        'recebido': recebido
      };

  factory Receita.fromJson(Map<String, dynamic> json) {
    return Receita.initAll(json['_id'], json['data'], json['valor'],
        json['descricao'], json['recebido']);
  }

  Receita.fromMap(Map map) {
    id = map["idCol"];
    data = map["dataCol"];
    valor = map["valorCol"];
    descricao = map["descricaoCol"];
    recebido = map["recebidoCol"];
  }
  Map toMap() {
    Map<String, dynamic> map = {
      "idCol": id,
      "dataCol": data,
      "valorCol": valor,
      "descricaoCol": descricao,
      "recebidoCol": recebido,
    };
    return map;
  }
}
