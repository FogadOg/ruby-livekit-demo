import { Controller } from "@hotwired/stimulus"



export default class extends Controller {
  static values = { token: String }

  async connect() {
    this.room = new LivekitClient.Room({
      // automatically manage subscribed video quality
      adaptiveStream: true,

      // optimize publishing bandwidth and CPU for published tracks
      dynacast: true,
    });

    console.log(this.room)

    // pre-warm connection, this can be called as early as your page is loaded
    this.room.prepareConnection("ws://127.0.0.1:7880", this.tokenValue);
    await this.room.connect("ws://127.0.0.1:7880", this.tokenValue);

  }
  async leave(){
      await this.room.disconnect();
      // window.location.href = "/"
  }
}
