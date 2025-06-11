% rebase('base.tpl')
<div class="bg-white shadow sm:rounded-lg">
    <div class="px-4 py-5 sm:px-6">
        <h1 class="text-2xl font-bold leading-7 text-gray-900 sm:tracking-tight">
            Documents avec le tag : {{tag_name}}
        </h1>
    </div>

    <div class="border-t border-gray-200 px-4 py-5 sm:p-6">
        % if documents:
            <div class="mb-6">
                <h2 class="text-sm font-medium text-gray-700 mb-2">Documents associés</h2>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-300">
                        <thead>
                            <tr class="bg-gray-50">
                                <th scope="col" class="py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900">Titre</th>
                                <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Type</th>
                                <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Sujet</th>
                                <th scope="col" class="relative py-3.5 pl-3 pr-4">
                                    <span class="sr-only">Actions</span>
                                </th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200 bg-white">
                            % for doc in documents:
                                <tr class="hover:bg-gray-50">
                                    <td class="whitespace-nowrap py-4 pl-4 pr-3 text-sm">
                                        <a href="/documents/{{doc['id']}}" class="font-medium text-primary hover:text-secondary">
                                            {{doc['title']}}
                                        </a>
                                    </td>
                                    <td class="whitespace-nowrap px-3 py-4 text-sm">
                                        % type_colors = {'lesson': 'blue', 'exercise': 'green', 'exam': 'yellow', 'solution': 'purple'}
                                        % type_labels = {'lesson': 'Cours', 'exercise': 'Exercice', 'exam': 'Examen', 'solution': 'Solution'}
                                        <span class="inline-flex items-center rounded-md px-2 py-1 text-xs font-medium ring-1 ring-inset
                                            % color = type_colors.get(doc['type'], 'gray')
                                            text-{{color}}-700 bg-{{color}}-50 ring-{{color}}-600/20">
                                            {{type_labels.get(doc['type'], doc['type'])}}
                                        </span>
                                    </td>
                                    <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                                        {{doc['subject_name']}}
                                    </td>
                                    <td class="relative whitespace-nowrap py-4 pl-3 pr-4 text-right text-sm font-medium">
                                        <form action="/documents/{{doc['id']}}/tags/{{tag_id}}" method="post" class="inline">
                                            <input type="hidden" name="_method" value="DELETE">
                                            <button type="submit" 
                                                    onclick="return confirm('Retirer ce tag du document ?');"
                                                    class="text-red-600 hover:text-red-900">
                                                Retirer le tag
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            % end
                        </tbody>
                    </table>
                </div>
            </div>
        % end

        <div class="space-y-6">
            <div>
                <h2 class="text-sm font-medium text-gray-700 mb-2">Ajouter ce tag à d'autres documents</h2>
                <form action="/tags/{{tag_id}}/documents" method="post">
                    <div class="mt-2 grid grid-cols-1 gap-4 sm:grid-cols-2 md:grid-cols-3">
                        % for doc in all_documents:
                            % if not any(d['id'] == doc['id'] for d in documents):
                                <label class="relative flex items-start">
                                    <div class="flex h-6 items-center">
                                        <input type="checkbox" 
                                               name="document_ids[]" 
                                               value="{{doc['id']}}"
                                               class="h-4 w-4 rounded border-gray-300 text-primary focus:ring-primary">
                                    </div>
                                    <div class="ml-3 text-sm leading-6">
                                        <span class="font-medium text-gray-900">{{doc['title']}}</span>
                                    </div>
                                </label>
                            % end
                        % end
                    </div>
                    <div class="mt-4 flex justify-end gap-3">
                        <a href="/tags/{{tag_id}}" 
                           class="rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
                            Retour au tag
                        </a>
                        <button type="submit"
                                class="rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-secondary focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-primary">
                            Ajouter aux documents sélectionnés
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
