import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static values = { token: String }

  async getDeviceIds() {

    const devices = await navigator.mediaDevices.enumerateDevices();
    const device = devices[4]
    console.log("device: ",device);
    return device["deviceId"]
  }
  

  async connect() {
    this.room = new LivekitClient.Room({
      // automatically manage subscribed video quality
      adaptiveStream: true,

      // optimize publishing bandwidth and CPU for published tracks
      dynacast: true,
    });

    console.log(this.room)

    // pre-warm connection, this can be called as early as your page is loaded
    this.room.prepareConnection("ws://localhost:7880", this.tokenValue);
    
    this.room.on('trackSubscribed', handleTrackSubscribed);
    
    await room.connect('ws://localhost:7880', this.tokenValue);

    const cameraId = getDeviceIds()
    
    const participant = room.localParticipant

    
    await participant.setCameraEnabled(true, {
      deviceId: cameraId,
    });



    // console.log("participant: ",participant);
    // await participant.setCameraEnabled(true);
    // await participant.setMicrophoneEnabled(true);

    // await participant.setScreenShareEnabled(true);

    

    function handleTrackSubscribed(
      track,
    ) {
      console.log("track: ",track);

      if (track.kind === Track.Kind.Video || track.kind === Track.Kind.Audio) {
        const element = track.attach();
        console.log("element: ",element);
        
        parentElement.appendChild(element);
      }
    }

    
  }
  async leave(){
      await this.room.disconnect();
      // window.location.href = "/"
  }
}
