import tkinter as tk
import json
from clips import Environment

class PhotographyDemo:

    def __init__(self):

        with open("questions.json", "r", encoding="utf-8") as f:
            self.questions = json.load(f)


        self.env = Environment()
        self.env.load("photography.clp")
        self.env.reset()
        self.env.run()


        self.root = tk.Tk()
        self.root.title("Photography Expert System")

        self.label = tk.Label(self.root, text="", wraplength=500, font=("Arial", 14))
        self.label.pack(pady=15)

        self.buttons = tk.Frame(self.root)
        self.buttons.pack(pady=10)

        self.update_ui()
        self.root.mainloop()


    def update_ui(self):
        for w in self.buttons.winfo_children():
            w.destroy()

        ask_fact = None
        result_fact = None

        for fact in self.env.facts():
            if fact.template.name == "ask":
                ask_fact = fact
            elif fact.template.name == "result":
                result_fact = fact


        if result_fact:
            self.label.config(text=self.translate_result(result_fact["text"]))
            return


        if ask_fact:
            qid = ask_fact["id"]
            q = self.questions[qid]

            self.label.config(text=q["text"])

            for key, text in q["options"].items():
                b = tk.Button(
                    self.buttons,
                    text=text,
                    width=40,
                    command=lambda k=key, q=qid: self.send_answer(q, k)
                )
                b.pack(pady=4)


    def send_answer(self, question_id, value):

        for fact in list(self.env.facts()):
            if fact.template.name == "ask":
                fact.retract()


        self.env.assert_string(
            f"(answer (id {question_id}) (value {value}))"
        )

        self.env.run()
        self.update_ui()


    def translate_result(self, key):
        results = {
            "study_masters": "Study the masters of photography.",
            "cross_pollinate_hobbies": "Cross-pollinate photography with music, drawing, writing or other hobbies.",
            "take_a_walk": "Take a short walk. Observe without taking photos.",
            "ask_friend_portrait": "Ask a friend, partner or family member to take your portrait.",
            "shadow_or_mirror": "Shoot your own shadow or take mirror self-portraits.",
            "shoot_camera_bag": "Shoot only objects from your camera bag.",
            "loved_object_photoshoot": "Do a photoshoot of one loved object at home.",
            "five_blocks": "Stay within five blocks of your home and photograph.",
            "big_city": "Go to the closest big city and photograph.",
            "international_adventure": "Plan an international photography adventure.",
            "road_trip": "Go on a road trip outside your home state.",
            "share_work": "Make a small exhibition, publish online or create a video.",
            "opposite_topic": "Choose one topic and do the opposite of what you usually do.",
            "shoot_juxtaposition": "Focus on juxtaposition in your photographs."
        }
        return results.get(key, key)


if __name__ == "__main__":
    PhotographyDemo()
