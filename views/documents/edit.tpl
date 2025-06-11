% rebase('base')
% action_url = '/documents/create' if not document else '/documents/' + str(document['id']) + '/edit'

<div class="max-w-2xl mx-auto py-6">
    <div class="bg-white shadow sm:rounded-lg">
        <div class="px-4 py-5 sm:px-6">
            <h2 class="text-2xl font-bold leading-7 text-gray-900 sm:tracking-tight">
                {{ 'Créer un document' if not document else 'Modifier le document' }}
            </h2>
            <p class="mt-1 text-sm text-gray-500">
                Remplissez les informations ci-dessous pour {{ 'créer' if not document else 'modifier' }} le document
            </p>
        </div>
        
        <div class="border-t border-gray-200">
            <form action="{{action_url}}" method="post" enctype="multipart/form-data" class="space-y-6 px-4 py-5 sm:p-6">
                <div>
                    <label for="title" class="block text-sm font-medium leading-6 text-gray-900">Titre</label>
                    <div class="mt-2">
                        <input type="text" 
                               name="title" 
                               id="title" 
                               value="{{document['title'] if document else ''}}" 
                               required 
                               class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-primary sm:text-sm sm:leading-6">
                    </div>
                </div>

                <div>
                    <label for="subject_id" class="block text-sm font-medium leading-6 text-gray-900">Sujet</label>
                    <div class="mt-2">
                        <select name="subject_id" 
                                id="subject_id" 
                                required 
                                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-inset focus:ring-primary sm:text-sm sm:leading-6">
                            <option value="">-- Choisir un sujet --</option>
                            % for subj in subjects:
                                <option value="{{subj['id']}}" {{ 'selected' if document and document['subject_id'] == subj['id'] else '' }}>
                                    {{subj['name']}}
                                </option>
                            % end
                        </select>
                    </div>
                </div>

                <div>
                    <label for="type" class="block text-sm font-medium leading-6 text-gray-900">Type</label>
                    <div class="mt-2">
                        <select name="type" 
                                id="type" 
                                required 
                                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-inset focus:ring-primary sm:text-sm sm:leading-6">
                            % for t, label in [('lesson', 'Cours'), ('exercise', 'Exercice'), ('exam', 'Examen'), ('solution', 'Solution')]:
                                <option value="{{t}}" {{ 'selected' if document and document['type'] == t else '' }}>{{label}}</option>
                            % end
                        </select>
                    </div>
                </div>

                <div>
                    <label for="description" class="block text-sm font-medium leading-6 text-gray-900">Description</label>
                    <div class="mt-2">
                        <textarea name="description" 
                                  id="description" 
                                  rows="4" 
                                  class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-primary sm:text-sm sm:leading-6"
                        >{{document['description'] if document else ''}}</textarea>
                    </div>
                </div>

                <div>
                    <label for="file" class="block text-sm font-medium leading-6 text-gray-900">
                        Fichier {{ '' if not document else '(laisser vide pour conserver le fichier actuel)' }}
                    </label>
                    <div class="mt-2">
                        <input type="file" 
                               name="file" 
                               id="file" 
                               {{ 'required' if not document else '' }}
                               class="block w-full text-sm text-gray-900 file:mr-4 file:py-2 file:px-4 file:rounded-md file:border-0 file:text-sm file:font-semibold file:bg-primary file:text-white hover:file:bg-secondary">
                    </div>
                    % if document and document.get('file_name'):
                        <p class="mt-2 text-sm text-gray-500">
                            Fichier actuel : {{document['file_name']}}
                        </p>
                    % end
                </div>

                <div class="flex gap-3 justify-end">
                    <a href="/documents" 
                       class="rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
                        Annuler
                    </a>
                    <button type="submit"
                            class="rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-secondary focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-primary">
                        {{ 'Créer' if not document else 'Mettre à jour' }}
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
