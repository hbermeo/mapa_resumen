library(leaflet)
library(sp)

puntos = data.frame(lat= -0.961451, lng= -80.689603, radio= 100)
puntos[2,] = c(-0.943429, -80.726853, 200)
puntos[3,] = c(-0.953384, -80.738011, 100)
puntos[4,] = c(-0.966257, -80.743161, 530)
puntos[5,] = c(-0.975354, -80.714665, 410)
puntos[6,] = c(-1.001786, -80.691319, 230)
puntos[7,] = c(-0.945661, -80.750027, 680)
puntos[8,] = c(-0.945317, -80.671406, 450)
puntos[9,] = c(-0.976384, -80.730286, 340)
puntos[10,] = c(-0.988055, -80.689259, 200)
puntos[,"zona"] = c("A","B","B","A","B","A","B","A","C","A")

linea = data.frame(lat =-0.962224 , lng= -80.733891 )
linea[2,] = c(-0.954843, -80.726166)
linea[3,] = c(-0.950724, -80.720845)
linea[4,] = c(-0.950724, -80.714837)
linea[5,] = c(-0.950509, -80.707670)
linea[6,] = c(-0.948664, -80.701619)
linea[8,] = c(-0.985995, -80.694838)
linea[9,] = c(-0.975869, -80.699216)
linea[10,] = c(-0.953384, -80.717755)

polig = data.frame(lat = -0.957160, lng = -80.699645 )
polig[2,] = c(-0.961280, -80.690890)
polig[3,] = c(-0.959992, -80.680934)
polig[4,] = c(-0.962910, -80.674754)
polig[5,] = c(-0.984451, -80.686684)
polig[6,] = c(-0.981275, -80.691748)
polig[7,] = c(-0.983249, -80.695782)
polig[8,] = c(-0.969175, -80.701276)
polig[9,] = c(-0.964369, -80.705310)

marcadores = data.frame(lat =-0.943944 , lng = -80.709515 )
marcadores[2,] = c(-0.936478, -80.718699)
marcadores[3,] = c(-0.938108, -80.745135)
marcadores[,"N_Barco"] = c("Isabela", "Gloria", "Manta")

barco = awesomeIcons(
  icon = "ship",
  library = "fa",
  iconColor = "blue",
  markerColor = "white",
  spin = FALSE
)

pal = colorFactor(c("green","blue","red"), c("A", "B","C"))

leaflet()%>% addProviderTiles(providers$CartoDB.Positron)%>%
  addCircles(lat = puntos$lat, lng = puntos$lng, group = "Zonas",
             radius =puntos$radio,weight = 1, color = "black",
             fillColor = pal(puntos$zona), fillOpacity = 0.3, label = paste("Zona ",puntos$zona),
             highlightOptions = highlightOptions(fillColor = "gold", color = "white",
                                                 weight = 5))%>%
  addPolylines(lat = linea$lat, lng = linea$lng, group = "Rutas",
               color = c("red","gold"), label = c("Ruta trebol", "Ruta condor"))%>%
  addPolygons(lat = polig$lat, lng = polig$lng, weight = 1, group = "Zona Priorizada",
              fillColor = "cyan", label = "Zona Priorizada",
              highlightOptions = highlightOptions(color = "white", weight = 6,
                                                  bringToFront = TRUE))%>%
  addLegend(group = "Zonas", pal = pal, values = puntos$zona, position = "bottomleft",
            title = "Leyenda Zonas")%>%
  addAwesomeMarkers(lat = marcadores$lat , lng = marcadores$lng, icon = barco,
                    popup = marcadores$N_Barco, group = "Barcos")%>%
  addLayersControl(overlayGroups = c("Zonas", "Rutas", "Zona Priorizada", "Barcos"),
                 options = layersControlOptions(collapsed = FALSE,),
                 position = "bottomright")
  
