(function () {
var fnx=function(){
    if(!document.head) {
        setTimeout(function(){fnx()},0);
        return;
    }
    if(document.getElementById("scr-sheet-ax")) {

        return;
        }
        var sheet = (function () {

            var style = document.createElement("style");
    
        if(style) {
    style.setAttribute("id", "scr-sheet-ax");
            style.appendChild(document.createTextNode(""));

            document.head.appendChild(style);
    
            return style.sheet;
         }
        })();
        
        var styles = [
            ".mobile-header{display:none!important}",
            "main{padding:1rem 0.7rem!important}",
            "footer{display:none!important}",
            "header>div{padding-top:0!important}",

        ];
    
        
        if(sheet) { styles.forEach(function (a) {
    
            sheet.insertRule(a.trim(), sheet.cssRules.length);
    
        });
        
        };
        fnx();
};
fnx();

    


})()
