import speech_recognition as sr
from pydub import AudioSegment
import os

def transcribe_audio(audio_file):
    # Converter o arquivo de áudio para WAV se não estiver em WAV
    if not audio_file.endswith('.wav'):
        audio = AudioSegment.from_file(audio_file)
        audio_file = audio_file.rsplit('.', 1)[0] + '.wav'
        audio.export(audio_file, format='wav')

    # Inicializar o reconhecedor de áudio
    recognizer = sr.Recognizer()

    # Carregar o arquivo de áudio
    with sr.AudioFile(audio_file) as source:
        audio_data = recognizer.record(source)  # Corretamente invocar o método record

    # Reconhecer o áudio usando a API do Google
    try:
        text = recognizer.recognize_google(audio_data, language='pt-BR')
        print("Transcrição: ")
        print(text)
        return text
    except sr.RequestError as e:
        print(f"Erro na solicitação da API: {e}")
    except sr.UnknownValueError:
        print("Não foi possível entender o áudio")

if __name__ == "__main__":
    import sys
    if len(sys.argv) < 2:
        print("Uso: python transcribe_audio.py <path-to-audio-file>")
        sys.exit(1)

    audio_file_path = sys.argv[1]

    if not os.path.isfile(audio_file_path):
        print(f"O arquivo {audio_file_path} não existe.")
        sys.exit(1)

    transcribe_audio(audio_file_path)

