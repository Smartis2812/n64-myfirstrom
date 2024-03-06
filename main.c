#include <nusys.h>
#include "stages.h"
#include "config.h"

static void vsyncCallback(int pendingTaskCount);

void mainproc(void * dummy)
{
    nuGfxInit();                                    // Initializes the graphics thread, creates a Z Buffer and Frame Buffer
    stage00_init();
    nuGfxFuncSet((NUGfxFunc)vsyncCallback);         //
    nuGfxDisplayOn();                               // allows the N64 to output to your television screen
    while(1)
        ;
}

void vsyncCallback(int pendingTaskCount)
{
    stage00_update();
    if(pendingTaskCount < 1)
        stage00_draw();
}
