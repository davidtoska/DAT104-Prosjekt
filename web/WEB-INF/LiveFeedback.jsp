
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart', 'bar']});
        google.charts.setOnLoadCallback(drawStuff);
        
        const FARGE_SUR = '#CD3337';
        const FARGE_MIDDELS = '#CF7C34';
        const FARGE_GLAD = '#30A82A';
      function drawStuff() {
        var frekvensTabell = "${requestScope.data}";
        //Frekvenstabellen er sortert i minutter. 20 slotter. 3, betyr 3 min bredde.
        
    	var dataArray = formatData(frekvensTabell, 15, 4);
        
        var button = document.getElementById('change-chart');
        var chartDiv = document.getElementById('chart_div');

        var data = google.visualization.arrayToDataTable(dataArray);

        var materialOptions = {
          width: 1500,
          chart: {
            title: 'Tilbakemeldinger',
            subtitle: 'Pågår nå'
          },
          series: {
            0: { targetAxisIndex: 0 } // Bind series 0 to an axis named 'Dårlig'.
          },
          axes: {
            y: {
              distance: {side: 'right', label: 'Antall'} // Right y-axis.
            }
          },
          colors: [FARGE_SUR,FARGE_MIDDELS,FARGE_GLAD]
        };

        var classicOptions = {
          width: 1500,
          series: {
            0: {targetAxisIndex: 0}
            //1: {targetAxisIndex: 1}
          },
          title: 'Tilbakemeldinger',
          vAxes: {
            // Adds titles to each axis.
            0: {title: 'Antall'}
          },
          axes: {
            y: {
              distance: {side: 'right', label: 'Antall'} // Right y-axis.
            }
            },
            colors: [FARGE_SUR,FARGE_MIDDELS,FARGE_GLAD]
        };

        
        function drawMaterialChart() {
          var materialChart = new google.charts.Bar(chartDiv);
          materialChart.draw(data, google.charts.Bar.convertOptions(materialOptions));
          button.innerText = 'Change to Classic';
          button.onclick = drawClassicChart;
        }

        function drawClassicChart() {
          var classicChart = new google.visualization.ColumnChart(chartDiv);
          classicChart.draw(data,classicOptions);
          button.innerText = 'Change to Material';
          button.onclick = drawMaterialChart;
        }
        //////////////////////////////////////////////////////////////////////
        /////////// FORMATERINGS-METODER /////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////
        /*
         * frekvensTabell: streng fra servlet.
         * antallSlotter: hvor mange slotter vi skal ha i diagrammet.
         * slottBredde: hvor mange minutter hver slott skal representere. 
         */
        function formatData(frekvensTabell, antallSlotter, slottBredde){
            let dataArr = lagDataArray(antallSlotter);
            let frekvensArr = lagFrekvensArray(frekvensTabell);
            
            for(let i = 0; i < antallSlotter; i++){
                let label = "" + (i+1)*slottBredde + "";
                let daarligIndex = i*slottBredde;
                let middelsIndex = i*slottBredde +1;
                let godIndex = i*slottBredde + 2;
                dataArr[i + 1][0] = label;
                dataArr[i + 1][1] = parseInt(frekvensArr[daarligIndex]);
                dataArr[i + 1][2] = parseInt(frekvensArr[middelsIndex]);
                dataArr[i + 1][3] = parseInt(frekvensArr[godIndex]);
            }
            return dataArr;
        }
        
        function lagDataArray(antallSlotter){
            //Legger til en ekstra på grunn av "labels"
            let res = new Array(antallSlotter +1);
            res[0] = ['Minutter', 'Dårlig', 'Middels', 'Bra'];
            for(let i = 1; i < antallSlotter +1; i++){
               res[i] = new Array(4); 
            }
            return res;
        }
        function lagFrekvensArray(frekvensTabell){
            let fSliced = frekvensTabell.slice(1, -1);
            return fSliced.split(", ");
        }
        

        //drawMaterialChart();
        drawClassicChart();
    };
    </script>
    </head>
    
    
    <body>
        
        <button id="change-chart">Change to Classic</button>
        <button>Start</button>
    <br><br>
    <div id="chart_div" style="width: 1250px; height: 500px;"></div>
        
    </body>
</html>
