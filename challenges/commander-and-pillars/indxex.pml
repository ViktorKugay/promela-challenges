#define OFF 0
#define ON 1

chan c[5] = [0] of {bit};

bit gate[5] = {OFF, ON, OFF, ON, ON}

#define isGateOpen (gate[0] & gate[1] & gate[2] & gate[3] & gate[4])

proctype Pillar(byte id; chan my) {
    bit signal

    do
        :: isGateOpen -> {
            break;
        }
        
        :: atomic {
            my?signal -> {
                gate[id] = !gate[id];
                gate[(id + 1) % 5] = !gate[(id + 1) % 5];
                gate[(id - 1) % 5] = !gate[(id - 1) % 5];
            }
        }
    od
}


active proctype Commander() {
    byte id;

    do
        ::!isGateOpen -> {
            select(id: 0 .. 4);
            printf("send $d\n", id);
            c[id]!1;
        }
        :: else  -> {
            printf("Open!");
            break;
        }
    od
}

init {
    byte id;
    
    for (id: 0 .. 4) {
        run Pillar(id, c[id])
    }
}