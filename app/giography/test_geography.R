#0.事前準備
setwd("C:/Programing/practice_R/app/giography")
wd <- getwd()
if (regexpr("app$",wd)<0){
  setwd("./app")
}
wd <- getwd()
if (regexpr("giography$",wd)<0){
  setwd("./giography")
}
wd <- getwd()

library(maps)
library(mapproj)

#1.地図データの読み込み
jpn.shp <- readRDS("data/gadm36_JPN_2_sf.rds")
#plot(jpn.shp)

library(dplyr)
glimpse(jpn.shp)

#2.統計データの読み込み
library(choroplethr)
data(df_japan_census)

#2-1.都道府県名などで一致する列を見つける
table(toupper(jpn.shp[["NAME_1"]]) == toupper(df_japan_census$region))

#3.plot
library(leaflet)

#3-1.塗る色をセット
pal <- colorNumeric("Blues", domain = df_japan_census$pop_2010, reverse = F)

#3-2.マウスオーバー時の表示内容を設定
#labels <- sprintf("<strong>%s</strong><br />%5.0f", paste0(jpn.shp$NL_NAME_1), df_japan_census$pop_2010) %>% lapply(htmltools::HTML)
labels <- sprintf("<strong>%s</strong><br/>%5.0f",
                  jpn.shp$NL_NAME_1,
                  df_japan_census$pop_2010) %>% lapply(htmltools::HTML)

#3-3.地図にプロット
jpn.shp %>%
  leaflet() %>%
  setView(lat = 37, lng = 139, zoom = 5) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addPolygons(fillOpacity = 0.5,
              weight = 1,
              fillColor = ~pal(df_japan_census$pop_2010),
              label = labels,
              labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "15px",
                direction = "auto"),
              highlight = highlightOptions(
                weight = 5,
                color = "#666",
                dashArray = "",
                fillOpacity = 0.7,
                bringToFront = TRUE)) %>%
  addLegend("bottomright", pal = pal, values = ~df_japan_census$pop_2010,
            title = "2010年人口分布")

