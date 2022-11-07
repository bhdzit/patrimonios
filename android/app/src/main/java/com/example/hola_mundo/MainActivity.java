package com.example.hola_mundo;


import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import android.content.Intent;
import android.provider.CalendarContract;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.io/battery";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("getBatteryLevel")) {
                                int batteryLevel = 23;

                                if (batteryLevel != -1) {
                                    result.success(batteryLevel);
                                } else {
                                    result.error("UNAVAILABLE", "Battery level not available.", null);
                                }
                            } else {
                                result.success("asdasdasd");
                            }
                        }
                );
    }
    public void insertarEnAgenda(String idUsuario, String idLugar, String nombreVisita, String fechaVisita){
        /*Toast.makeText(this,"idUsuario: " + idUsuario+"\n"+"idLugar: "+idLugar+"\n"+"nombreVisita: " +nombreVisita+"\n"+
                "fechaVisita: " + fechaVisita.replace('/','-'),Toast.LENGTH_LONG).show();*/


        String url = "https://centrodeinformacion-isic-itsoeh.org.mx/php/app_VisitasUsuario.php?id_agenda_usuario="
                +idUsuario+"&id_agenda_lugar="+idLugar+"&nombre_visita="+nombreVisita+"&fecha_visita="+
                fechaVisita.replace('/','-');

       // url = url.replace(" ", "%20");
       // jrq = new JsonObjectRequest(Request.Method.GET, url, null, this, this);
       // rq.add(jrq);
    }

/*
    String tipoOp ="agendar";
    String datos[][]= new String[12][12];
    String lugarAVisitar = "";
    // progress.show();
    //INSERTAR EN AGENDA
    String idLugar = getIntent().getStringExtra("parametro");
    Date date = new Date();
    DateFormat hourdateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

    String idUsuario = getIntent().getStringExtra("idUsuario");

    //insertarEnAgenda(idUsuario,idLugar,
    //       "Visita a "+lugarAVisitar);

    //String nombreLugar= txtUbicacion.toString();
    Intent calIntent = new Intent(Intent.ACTION_INSERT);
                            calIntent.setType("vnd.android.cursor.item/event");
                            calIntent.putExtra(CalendarContract.Events.TITLE, "Visita a "+lugarAVisitar);
                            calIntent.putExtra(CalendarContract.Events.EVENT_LOCATION, ""+lugarAVisitar);
                            calIntent.putExtra(CalendarContract.Events.DESCRIPTION, "");
    startActivity(calIntent);

*/



}
