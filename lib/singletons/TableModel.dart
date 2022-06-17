class TableModel {
  static final TableModel _table = TableModel._internal();

  int rowCount = 5;
  int columnCount = 5;

  List<List<String>> table = [];

  TableModel._internal();

  factory TableModel() {
    return _table;
  }

  void initTable() {
    List<List<String>> newTable = [];
    for (int i = 0; i < rowCount; i++) {
      List<String> row = [];
      for (int j = 0; j < columnCount; j++) {
        row.add("");
      }
      newTable.add(row);
    }
    table = newTable;
  }

  List<List<String>> getTable() {
    if (table.isEmpty) {
      initTable();
    }
    return table;
  }

  int getRowCount() {
    return rowCount;
  }

  int getColumnCount() {
    return columnCount;
  }

  void setRowCount(int rowCount) {
    if (this.rowCount < rowCount) {
      // add rows
      for (int i = this.rowCount; i < rowCount; i++) {
        List<String> row = [];
        for (int j = 0; j < columnCount; j++) {
          row.add("");
        }
        table.add(row);
      }
    } else if (this.rowCount > rowCount) {
      // delete rows
      int rowsToDelete = this.rowCount - rowCount;
      for(int i = 0; i < rowsToDelete; i++) {
        table.removeLast();
      }
    }
    this.rowCount = rowCount;
  }

  void setColumnCount(int columnCount) {
    if (this.columnCount < columnCount) {
      // add columns
      for(int i = 0; i < rowCount; i++) {
        for(int j = this.columnCount; j < columnCount; j++) {
          table[i].add("");
        }
      }
    } else if (this.columnCount > columnCount) {
      // remove columns
      for(int i = 0; i < rowCount; i++) {
        int end = table[i].length;
        table[i].removeRange(columnCount, end);
      }
    }
    this.columnCount = columnCount;
  }

  void setValue(int row, int column, String value) {
    table[row][column] = value;
  }

  void printTable() {
    for(int i = 0; i < rowCount; i++) {
      print(table[i]);
    }
  }

  void clear() {
    for(int i = 0; i < rowCount; i++) {
      for(int j = 0; j < columnCount; j++) {
        table[i][j] = "";
      }
    }
  }
}

main() {
  TableModel t1 = TableModel();
  t1.getTable();
  t1.setValue(0, 0, "a");
  t1.setValue(1, 1, "a");
  t1.setValue(2, 2, "a");
  t1.setValue(3, 3, "a");
  t1.setValue(4, 4, "a");
  t1.printTable();
}
