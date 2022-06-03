import './weather/requests.dart';
import './notes/requests.dart';
import './jokes/requests.dart';

Future<List<String>> assistantRequest(String text) async {
  List<String> response = [];
  if(text.toLowerCase().startsWith("clima en ")) {
    String city = text.replaceAll("clima en ", "");
    response.add(await currentWeather(city));
  } else if(text.toLowerCase().startsWith("guardar en notas ")) {
    String note = text.toLowerCase().replaceAll("guardar en notas ", "");
    response.add("Nota guardada.");
    await saveNote(note);
  } else if(text.toLowerCase().compareTo("mostrar notas") == 0) {
    response = await getAllNotes();
  } else if(text.toLowerCase().startsWith("eliminar nota")) {
    String pos = text.replaceAll("eliminar nota ", "");
    await deleteNote(pos);
    response.add("Nota eliminada.");
  } else if(text.toLowerCase().compareTo("cuéntame un chiste") == 0 ||
      text.toLowerCase().compareTo("contar un chiste") == 0) {
    response.add(await getJoke());
  }
  return response;
}