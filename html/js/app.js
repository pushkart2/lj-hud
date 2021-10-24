var carui = false;
var color = null;
// money
(() => {
    Config = {};
    Update = function(data) {
        if(data.type == "cash") {
            $(".money-cash").css("display", "block");
            $("#cash").html(data.cash);
            if (data.minus) {
                $(".money-cash").append('<p class="moneyupdate minus">-<span id="cash-symbol">&dollar;&nbsp;</span><span><span id="minus-changeamount">' + data.amount + '</span></span></p>')
                $(".minus").css("display", "block");
                setTimeout(function() {
                    $(".minus").fadeOut(750, function() {
                        $(".minus").remove();
                        $(".money-cash").fadeOut(750);
                    });
                }, 3500)
            } else {
                $(".money-cash").append('<p class="moneyupdate plus">+<span id="cash-symbol">&dollar;&nbsp;</span><span><span id="plus-changeamount">' + data.amount + '</span></span></p>')
                $(".plus").css("display", "block");
                setTimeout(function() {
                    $(".plus").fadeOut(750, function() {
                        $(".plus").remove();
                        $(".money-cash").fadeOut(750);
                    });
                }, 3500)
            }
        }
    };

    Close = function() {
    };

    Show = function(data) {
        $(".money-cash").css("display", "block");
        $("#cash").html(data.cash);
        if(data.type == "cash") {
            $(".money-cash").fadeIn(150);
            $("#cash").html(data.cash);
            setTimeout(function() {
                $(".money-cash").fadeOut(750);
            }, 3500)
        } 
    };

// playerui
    UpdateHud = function(data) {
        var Show = "block";
        if (data.show) {
            Show = "none";
            $(".ui-container").css("display", Show);
            
            return;
    }
            $(".ui-container").css("display", Show);

    // voice 
    Progress(data.talking, ".mic");
    if (data.speaking == 1) {
    $(".mic").css({"stroke":"yellow"}); // mic highlight
    } else {
    $('.mic').css({"stroke":"#fff"});
    }

    // voice switch
    if (data.talking) {
    $(".microphone").css({"display":"block"}); // don't touch if you don't understand
    $(".headset").css({"display":"none"}); // don't touch if you don't understand
    }

    // radio 
    Progress(data.talking, ".mic"); 
    if (data.radio && data.speaking == 1) {
    $(".mic").css({"stroke":"#ff5454"}); // radio highlight
    }

    // radio switch
    if (data.radio) {
    $(".microphone").css({"display":"none"}); // don't touch if you don't understand
    $(".headset").css({"display":"block"}); // don't touch if you don't understand
    }

    // health radial
    if ( data.health <=150){
        color = "red"
    } else if (data.health>150 ){
        color = "#00E676"
    }

    if (Config.DynamicHealth == false) {
    Progress(data.health - 100, ".hp");
    if (data.health >= 196) {
        $('.hvida').fadeIn(750);
        $('.hp').css("stroke", color);
        $('.vida').css("fill", color);
        $('.vida').css("fill-opacity", "0.4");
    }
    if (data.health <= 195) {
        $('.hvida').fadeIn(750);
        $('.hp').css("stroke", color);
        $('.vida').css("fill", color);
    }
    if (data.health <= 100) { 
        $('.hp').css("stroke", color);
        $('.vida').css("fill", color);
        $('.vida').css("fill-opacity", "1.0");
    }
    }

    if (Config.DynamicHealth == true) {
    Progress(data.health - 100, ".hp");
    if (data.health <= 195) {
        $('.hvida').fadeIn(750);
        $('.hp').css("stroke", color);
        $('.vida').css("fill", color);
    }
    if (data.health >= 196) {
        $('.hvida').fadeOut(750);
        $('.hp').css("stroke", color);
        $('.vida').css("fill", color);
        $('.vida').css("fill-opacity", "0.4");
    }
    if (data.health <= 100) { 
        $('.hp').css("stroke", color);
        $('.vida').css("fill", color);
        $('.vida').css("fill-opacity", "1.0");
    }
    }  

    // armor radial
    if (Config.DynamicArmor == false) {
    Progress(data.armor, ".armor");
    if (data.armor > 100) {
        $('.amr').css("fill", "#2962FF");
    }
    if (data.armor <= 45) {
        $('.amr').css("fill", "red");
    } 
    }
    
    if (Config.DynamicArmor == true) {
    Progress(data.armor, ".armor");
    if (data.armor > 100) {
        $('.amr').css("fill", "#2962FF");
    }
    if (data.armor <= 45) {
        $('.amr').css("fill", "red");
    } 
    if (data.armor > 0) {
        $(".harmor").fadeIn(750);
    } else {
        $('.harmor').fadeOut(750);
    }
    }

    // hunger radial
    if (Config.DynamicHunger == false) {
    Progress(data.hunger, ".hunger");
    if (data.hunger >= 96) {
        $('.hhunger').fadeIn(750);
    }
    if (data.hunger <= 45) {
        $('.fome').css("fill", "red");
    } else {
        $('.fome').css("fill", "#f0932b");
    }
    }

    if (Config.DynamicHunger == true) {
    Progress(data.hunger, ".hunger");
    if (data.hunger <= 95) {
        $('.hhunger').fadeIn(750);
    }
    if (data.hunger >= 96) {
        $('.hhunger').fadeOut(750);
    }
    if (data.hunger <= 45) {
        $('.fome').css("fill", "red");
    } else {
        $('.fome').css("fill", "#f0932b");
    }
    }

    // thirst radial
    if (Config.DynamicThirst == false) {
    Progress(data.thirst, ".thirst");
    if (data.thirst >= 96) {
        $('.hthirst').fadeIn(750);
    }
    if (data.thirst <= 45) {
        $('.cede').css("fill", "red");
    } else {
        $('.cede').css("fill", "#3467d4");
    }
    }

    if (Config.DynamicThirst == true) {
    Progress(data.thirst, ".thirst");
    if (data.thirst <= 95) {
        $('.hthirst').fadeIn(750);
    }
    if (data.thirst >= 96) {
        $('.hthirst').fadeOut(750);
    }
    if (data.thirst <= 45) {
        $('.cede').css("fill", "red");
    } else {
        $('.cede').css("fill", "#3467d4");
    }
    }

    // oxygen radial
    if (Config.DynamicOxygen == false) {
    Progress(data.oxygen, ".oxygen");
    if (data.oxygen >= 99) {
        $('.ooxygen').fadeIn(750);
    }
    if (data.oxygen <= 45) {
        $('.aome').css("fill", "red");
    } else {
        $('.aome').css("fill", "#9dbad5");
    }
    }
    
    if (Config.DynamicOxygen == true) {
    Progress(data.oxygen, ".oxygen");
    if (data.oxygen <= 99) {
        $('.ooxygen').fadeIn(750);
    }
    if (data.oxygen >= 99) {
        $('.ooxygen').fadeOut(750);
    }
    if (data.oxygen <= 45) {
        $('.aome').css("fill", "red");
    } else {
        $('.aome').css("fill", "#9dbad5");
    }
    }

    // stress radial
    if (Config.DynamicStress == false) {
    Progress(data.stress, ".stress");
    if (data.stress <= 2) {
        $('.hstress').fadeIn(750);
    }
    }

    if (Config.DynamicStress == true) {
    Progress(data.stress, ".stress");
    if (data.stress >= 3) {
        $('.hstress').fadeIn(750);
    }
    if (data.stress <= 2) {
        $('.hstress').fadeOut(750);
    }
    }

// carui

    CarHud = function(data) {
        if (data.show) {
            carui = true;
            $(".ui-car-container").fadeIn();
            if (Config.Engine == "new") {
                $(".circle-engine").fadeOut(750);
                }
        } else {
            carui=false;
            $(".ui-car-container").fadeOut();
            if (Config.DynamicNitro == false) {
            $(".hnitrous").fadeOut(750);
            }
            $('.circle-engine').hide();
            $('.circle-harness').hide();
        }
    };

    // seatbelt
    ToggleSeatbelt = function(data) {
        if (data.seatbelt) {
            $(".car-seatbelt-info img").fadeOut(750);
        } else {
            $(".car-seatbelt-info img").fadeIn(750);
        }
    };

    // harness
    ToggleHarness = function(data) {
        if (data.harness) {
            $(".circle-harness").fadeIn(750);
        } else {
            $(".circle-harness").fadeOut(750);
        }
    };

    // new engine
    if (Config.DynamicEngine == false && Config.EngineType == "new" && carui == true) {
    Progress(data.engine, ".engine");
    if (data.engine >= 0) {
        $('.circle-engine').fadeIn(750);
    }
    if (data.engine <= 45){
        $('.engine').css("stroke", "#B71C1C");
        $('.hengine').css("fill", "#B71C1C"); 
    }
    else if (data.engine <= 75 && data.engine >= 46 ) {
        $('.engine').css("stroke", "#f0932b");
        $('.hengine').css("fill", "#f0932b");
    } else {
        $('.engine').css("stroke", "#00C853");
        $('.hengine').css("fill", "#00C853");
    }
    }

    if (Config.EngineType == "new" &&  carui == true) {
        $('.car-seatbelt-info').css("margin-left", "-28px");
        $(".engine-red img").fadeOut(750);
        $(".engine-orange img").fadeOut(750);
    Progress(data.engine, ".engine");
    if (data.engine <= 95) {
        $('.circle-engine').fadeIn(750);
    }

    if (Config.DynamicEngine == true) {
        if (data.engine >= 96) {
            $('.circle-engine').fadeOut(750);
    }
    }
    if (data.engine <= 45){
        $('.engine').css("stroke", "#B71C1C");
        $('.hengine').css("fill", "#B71C1C"); 
    }
    else if (data.engine <= 75 && data.engine >= 46 ) {
        $('.engine').css("stroke", "#f0932b");
        $('.hengine').css("fill", "#f0932b");
    } else {
        $('.engine').css("stroke", "#00C853");
        $('.hengine').css("fill", "#00C853");
    }
    }

    // np engine
    if (Config.EngineType == "np") {
        $(".circle-engine").fadeOut(750);
    if (data.engine <= 45) {
        $(".engine-red img").fadeIn(750);
        $(".engine-orange img").fadeOut(750);
    }
    else if (data.engine <= 75 && data.engine >= 46 ) {
        $(".engine-red img").fadeOut(750);
        $(".engine-orange img").fadeIn(750);
    } else {
        $(".engine-red img").fadeOut(750);
        $(".engine-orange img").fadeOut(750);
    }
    }

    // nitro radial
    if (Config.DynamicNitro == false) {
    Progress(data.nivel, ".nitrous");
    if (data.nivel >= 0 && carui ==true) {   
        $('.hnitrous').fadeIn(750);
    }
    if (data.activo) {
        $(".nitrous").css({"stroke":"#ff5454"});
        $(".nitronot").css({"display":"none"}); // don't touch if you don't understand
        $(".nitroactive").css({"display":"block"}); // don't touch if you don't understand
    } else {
        $(".nitrous").css({"stroke":"#F06292"});
        $(".nitronot").css({"display":"block"}); // don't touch if you don't understand
        $(".nitroactive").css({"display":"none"}); // don't touch if you don't understand
    }  
    }

    if (Config.DynamicNitro == true) {
    Progress(data.nivel, ".nitrous");
    if (data.activo) {
        $(".nitrous").css({"stroke":"#ff5454"});
        $(".nitronot").css({"display":"none"}); // don't touch if you don't understand
        $(".nitroactive").css({"display":"block"}); // don't touch if you don't understand
    } else {
        $(".nitrous").css({"stroke":"#F06292"});
        $(".nitronot").css({"display":"block"}); // don't touch if you don't understand
        $(".nitroactive").css({"display":"none"}); // don't touch if you don't understand
    }  
    if (data.nivel > 0 && carui==true) {
        $(".hnitrous").fadeIn(750);
    } else {       
        $('.hnitrous').fadeOut(750);
    }
    }

    // dev radial
    if (data.devmode) {
        $(".circle-dev").fadeIn(750);
    } else {
        $(".circle-dev").fadeOut(750);
    }

    // speed
    setProgressSpeed(data.speed, ".progress-speed");

    // fuel
    setProgressFuel(data.fuel, ".progress-fuel");
    if (data.fuel <= 20) {
        $('.progress-fuel').css("stroke", "red"); // 20% fuel left color
    } else if (data.fuel <= 30) {
        $('.progress-fuel').css("stroke", "orange"); // 30% fuel left color
    } else {
        $('.progress-fuel').css("stroke", "#fff"); // other fuel left color
    }
        
    // cinematic mode
    if (data.cinematicmode) {
        $(".ui-car-otherinfo").css("left", "-52.5%");
        $(".ui-bars-container").css("left", "-100%");
        $(".outline").hide();
    } else {
        $(".ui-car-otherinfo").css("left", "22.5%");
        $(".ui-bars-container").css("left", "1%");
    }
};

// compass
window.addEventListener("message", function (event) {
    if (event.data.action == "display") {
        type = event.data.type
        value = event.data.value
        if (type === null) {
            $(".street").hide();
            $(".compass").hide();
        } else  {
            $('.street').html(type);
            $(".street").show();
            $('.compass').html(value);
            $(".compass").show();
            if (value  !== undefined) {
                bar = document.getElementsByTagName("svg")[0];
                bar.setAttribute("viewBox", ''+ (value - 90) + ' 0 180 5');
                heading = document.getElementsByTagName("svg")[1];
                heading.setAttribute("viewBox", ''+ (value - 90) + ' 0 180 1.5');
            }
        }
        $(".ui").fadeIn();
    } else if (event.data.action == "hide") {
        $(".ui").fadeOut();
    }
});

// on load
window.onload = function(e) {
    window.addEventListener('message', function(event) {
        var data = event.data;
        switch(event.data.action) {
            case "close":
                Close();
                break;
            case "update":
                Update(event.data);
                break;
            case "show":
                Show(event.data);
                break;
            case "hudtick":
                UpdateHud(event.data);
                break;
            case "car":
                CarHud(event.data);
                break;
            case "engine":
                EngineHealth(event.data);
                break;
            case "seatbelt":
                ToggleSeatbelt(event.data);
                break;
            case "harness":
                ToggleHarness(event.data);
                break;
            case "nitrous":
                UpdateNitrous(event.data);
                break;
            case "UpdateProximity":
                UpdateProximity(event.data);
                break;
            case "talking":
                SetTalkingState(event.data);
                break;
            case "displaySquareUI":
                $(".circlemapborder").hide();
                $(".outline").show();
                $(".squaremapborder").fadeIn(300);
            break;
            case "hideSquareUI":
                $(".circlemapborder").hide();

                $(".squaremapborder").hide();
            break;
            case "displayCircleUI":
                $(".squaremapborder").hide();
                $(".outline").show();
                $(".circlemapborder").show();
            break;
            case "hideCircleUI":
                $(".squaremapborder").hide();

                $(".circlemapborder").hide();
            break;
        }
    })
}

// progress
    function ProgressVoip(percent, element) {
        var circle = document.querySelector(element);
        var radius = circle.r.baseVal.value;
        var circumference = radius * 200 * Math.PI;
        circle.style.strokeDasharray = `${circumference} ${circumference}`;
        circle.style.strokeDashoffset = `${circumference}`;
        const offset = circumference - ((-percent * 100) / 100 / 100) * circumference;
        circle.style.strokeDashoffset = -offset;
    }
    function Progress(percent, element) {
        var circle = document.querySelector(element);
        var radius = circle.r.baseVal.value;
        var circumference = radius * 2 * Math.PI;
        circle.style.strokeDasharray = `${circumference} ${circumference}`;
        circle.style.strokeDashoffset = `${circumference}`;
        const offset = circumference - ((-percent * 100) / 100 / 100) * circumference;
        circle.style.strokeDashoffset = -offset;
    }
    function setProgressSpeed(value, element){
        var circle = document.querySelector(element);
        var radius = circle.r.baseVal.value;
        var circumference = radius * 2 * Math.PI;
        var html = $(element).parent().parent().find('span');
        var percent = value*100/450;
        circle.style.strokeDasharray = `${circumference} ${circumference}`;
        circle.style.strokeDashoffset = `${circumference}`;
        const offset = circumference - ((-percent*73)/100) / 100 * circumference;
        circle.style.strokeDashoffset = -offset;
        html.text(value);
      }
      function setProgressFuel(percent, element) {
        var circle = document.querySelector(element);
        var radius = circle.r.baseVal.value;
        var circumference = radius * 2 * Math.PI;
        var html = $(element).parent().parent().find("span");
        circle.style.strokeDasharray = `${circumference} ${circumference}`;
        circle.style.strokeDashoffset = `${circumference}`;
        const offset = circumference - ((-percent * 73) / 100 / 100) * circumference;
        circle.style.strokeDashoffset = -offset;
        html.text(Math.round(percent));
      }
})();
