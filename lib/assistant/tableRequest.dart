import "../singletons/TableModel.dart";

int number(String msg) {
  int numero = 0;
  if(msg == 'una'){
    numero = 1;
  } else if (msg == 'dos'){
    numero = 2;
  } else if (msg == 'tres'){
    numero = 3;
  } else if (msg == 'cuatro'){
    numero = 4;
  } else if (msg == 'cinco'){
    numero = 5;
  }else if (msg == 'seis'){
    numero = 6;
  }else if (msg == 'siete'){
    numero = 7;
  }else if (msg == 'ocho'){
    numero = 8;
  }else if (msg == 'nueve'){
    numero = 9;
  }else if (msg == 'diez'){
    numero = 10;
  }
  return numero;
}

List<String> tableRequest(String text) {
  TableModel tModel = TableModel();

  List<String> colores = ['amarillo', 'azul', 'rojo', 'rosa', 'morado', 'verde',
    'negro', 'gris', 'blanco', 'lima', 'violeta', 'magenta', 'fucsia', 'menta',
    'lavanda', 'rosado', 'cobre', 'canela', 'dorado', 'turquesa', 'amatista',
    'purpura', 'vino'];

  List<String> response = [];
  print(text);
  if(text.toLowerCase().startsWith("agregar")) {
    List<String> palabras = text.toLowerCase().split(" ");
    int num = -1;
    try {
      num = int.parse(palabras[1]);
    } catch (e) {
      num = number(palabras[1]);
    }
    if(palabras[2] == "fila" || palabras[2] == "filas") {
      tModel.setRowCount(tModel.getRowCount() + num);
      response.add("agregando filas");
    } else if(palabras[2] == "columna" || palabras[2] == "columnas") {
      tModel.setColumnCount(tModel.getColumnCount() + num);
      response.add("agregando columnas");
    }
  } else if(text.toLowerCase().startsWith("quitar")) {
    List<String> palabras = text.toLowerCase().split(" ");
    int num = -1;
    try {
      num = int.parse(palabras[1]);
    } catch (e) {
      num = number(palabras[1]);
    }
    if(palabras[2] == "fila" || palabras[2] == "filas") {
      tModel.setRowCount(tModel.getRowCount() - num);
      response.add("quitando filas");
    } else if(palabras[2] == "columna" || palabras[2] == "columnas") {
      tModel.setColumnCount(tModel.getColumnCount() - num);
      response.add("quitando columnas");
    }
  } else if(text.toLowerCase().startsWith("modificar")) {
    List<String> palabras = text.toLowerCase().split(" ");
    print(palabras);
    String cad = "";
    cad += cad += palabras[5];
    for(int i = 6; i < palabras.length; i++) {
      cad += " " + palabras[i];
    }
    int row = -1;
    int column = -1;
    if(palabras[1] == "fila" && palabras[3] == "columna") {
      row = colores.indexOf(palabras[2]);
      column = colores.indexOf(palabras[4]);
    } else {
      row = colores.indexOf(palabras[4]);
      column = colores.indexOf(palabras[2]);
    }
    tModel.setValue(row, column, cad);
  } else if(text.toLowerCase().startsWith("limpiar tabla")) {
    tModel.clear();
    response.add("limpiando tabla");
  } else if(text.toLowerCase().startsWith("eliminar")) {
    List<String> palabras = text.toLowerCase().split(" ");
    print(palabras);
    int row = -1;
    int column = -1;
    if(palabras[1] == "fila" && palabras[3] == "columna") {
      row = colores.indexOf(palabras[2]);
      column = colores.indexOf(palabras[4]);
    } else {
      row = colores.indexOf(palabras[4]);
      column = colores.indexOf(palabras[2]);
    }
    tModel.setValue(row, column, "");
  }

  return response;
}