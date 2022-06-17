
import 'package:dialog_flowtter/dialog_flowtter.dart';

import './weather/requests.dart';
import './notes/requests.dart';
import './jokes/requests.dart';
import './news/requests.dart';

Future<String> chatbot(message) async {
  DialogAuthCredentials credentials = await DialogAuthCredentials.fromFile("assets/credentials.json");
  DialogFlowtter dialogflow = DialogFlowtter(
    credentials: credentials,
    sessionId: "s1"
  );
  QueryInput queryInput = QueryInput(
    text: TextInput(
      text: message,
      languageCode: "es"
    )
  );
  DetectIntentResponse response = await dialogflow.detectIntent(
    queryInput: queryInput,
  );
  String? textResponse = response.text;
  if(textResponse != null) {
    return textResponse.toString();
  } else {
    return "";
  }
}

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
  } else if(text.toLowerCase().startsWith("noticias sobre")) {
    String category = text.toLowerCase().replaceAll("noticias sobre ", "");
    List<String> res = await getNews(category);
    response = res;
  } else if(text.toLowerCase().startsWith("abrir tabla")) {
    response.add("Abriendo tabla...");
  } else {
    String chatbotResponse = await chatbot(text);
    response.add(chatbotResponse);
  }
  return response;
}