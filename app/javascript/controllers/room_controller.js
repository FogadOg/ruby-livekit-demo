import { Controller } from "@hotwired/stimulus"



export default class extends Controller {
  static values = { token: String }

  connect() {
    const room = new LivekitClient.Room({
      // automatically manage subscribed video quality
      adaptiveStream: true,

      // optimize publishing bandwidth and CPU for published tracks
      dynacast: true,
    });

    console.log(room)
    // pre-warm connection, this can be called as early as your page is loaded
    room.prepareConnection("ws://127.0.0.1:7880", this.tokenValue);
    room.connect("ws://127.0.0.1:7880", this.tokenValue);

  }
}
