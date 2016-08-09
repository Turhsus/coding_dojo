from django.shortcuts import render

from django.http import HttpResponse, Http404, HttpResponseNotFound
def index(request):
	return render(request, 'quiz/index.html')

def show(request, question_id):
	context = {
		'id': question_id,
		'question': "Why is a boxing ring square?"
	}
	return render(request, 'quiz/index.html', context)
