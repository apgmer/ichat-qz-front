/**
 * Created by guoxiaotian on 2017/5/30.
 */


var map;

var initMap = function(){
    map = new AMap.Map('mapContainer', {
        resizeEnable: true,
        zoom: 14,
        // position: [116.480983, 39.989628],//marker所在的位置
    });

}


var changeLoc = function (jsonData) {
    var position = [jsonData.lon, jsonData.lat]
    map.clearMap()
    var marker = new AMap.Marker({
        position: position
    });
    marker.setMap(map);
    map.setZoomAndCenter(14, position);
}
