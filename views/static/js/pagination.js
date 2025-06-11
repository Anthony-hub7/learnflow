class Pagination {
    constructor(container, itemsPerPage = 10) {
        this.container = container;
        this.itemsPerPage = itemsPerPage;
        this.items = [...container.querySelectorAll('[data-pagination-item]')];
        this.currentPage = 1;
        this.totalPages = Math.ceil(this.items.length / this.itemsPerPage);
        
        this.init();
    }

    init() {
        // Créer les contrôles de pagination
        this.createPaginationControls();
        // Afficher la première page
        this.showPage(1);
    }

    createPaginationControls() {
        const paginationDiv = document.createElement('div');
        paginationDiv.className = 'flex items-center justify-between px-4 py-3 sm:px-6 mt-4';
        
        // Informations sur la pagination
        const infoDiv = document.createElement('div');
        infoDiv.className = 'text-sm text-gray-700';
        
        // Boutons de navigation
        const buttonsDiv = document.createElement('div');
        buttonsDiv.className = 'flex gap-2 items-center';
        
        // Bouton précédent
        const prevButton = document.createElement('button');
        prevButton.className = 'relative inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 transition-colors';
        prevButton.innerHTML = '<i class="fas fa-chevron-left mr-2"></i>Précédent';
        prevButton.onclick = () => this.previousPage();
        
        // Bouton suivant
        const nextButton = document.createElement('button');
        nextButton.className = 'relative inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 transition-colors';
        nextButton.innerHTML = 'Suivant<i class="fas fa-chevron-right ml-2"></i>';
        nextButton.onclick = () => this.nextPage();
        
        // Numéros de page
        const pageNumbers = document.createElement('div');
        pageNumbers.className = 'flex gap-1 items-center';
        
        this.pageInfo = infoDiv;
        this.prevButton = prevButton;
        this.nextButton = nextButton;
        this.pageNumbers = pageNumbers;
        
        buttonsDiv.appendChild(prevButton);
        buttonsDiv.appendChild(pageNumbers);
        buttonsDiv.appendChild(nextButton);
        
        paginationDiv.appendChild(infoDiv);
        paginationDiv.appendChild(buttonsDiv);
        
        this.container.parentNode.insertBefore(paginationDiv, this.container.nextSibling);
        this.updatePageNumbers();
    }

    updatePageNumbers() {
        this.pageNumbers.innerHTML = '';
        
        // Mise à jour de l'info de pagination
        this.pageInfo.textContent = `Affichage de ${(this.currentPage - 1) * this.itemsPerPage + 1} à ${Math.min(this.currentPage * this.itemsPerPage, this.items.length)} sur ${this.items.length} éléments`;
        
        // Afficher les numéros de page avec ellipsis
        for (let i = 1; i <= this.totalPages; i++) {
            if (
                i === 1 || 
                i === this.totalPages || 
                (i >= this.currentPage - 1 && i <= this.currentPage + 1)
            ) {
                const pageButton = document.createElement('button');
                pageButton.className = `relative inline-flex items-center px-3 py-2 text-sm font-semibold ${
                    i === this.currentPage 
                        ? 'bg-primary text-white hover:bg-secondary' 
                        : 'text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50'
                } rounded-md transition-colors`;
                pageButton.textContent = i;
                pageButton.onclick = () => this.showPage(i);
                this.pageNumbers.appendChild(pageButton);
            } else if (
                (i === this.currentPage - 2 && i > 1) ||
                (i === this.currentPage + 2 && i < this.totalPages)
            ) {
                const ellipsis = document.createElement('span');
                ellipsis.className = 'px-2 py-2 text-gray-500';
                ellipsis.textContent = '...';
                this.pageNumbers.appendChild(ellipsis);
            }
        }
        
        // Activer/désactiver les boutons précédent/suivant
        this.prevButton.disabled = this.currentPage === 1;
        this.nextButton.disabled = this.currentPage === this.totalPages;
        
        // Ajouter des classes pour les boutons désactivés
        if (this.prevButton.disabled) {
            this.prevButton.classList.add('opacity-50', 'cursor-not-allowed');
        } else {
            this.prevButton.classList.remove('opacity-50', 'cursor-not-allowed');
        }
        
        if (this.nextButton.disabled) {
            this.nextButton.classList.add('opacity-50', 'cursor-not-allowed');
        } else {
            this.nextButton.classList.remove('opacity-50', 'cursor-not-allowed');
        }
    }

    showPage(pageNumber) {
        this.currentPage = pageNumber;
        const start = (pageNumber - 1) * this.itemsPerPage;
        const end = start + this.itemsPerPage;
        
        // Animation de fondu pour une transition plus douce
        this.items.forEach((item, index) => {
            if (index >= start && index < end) {
                item.style.display = '';
                item.style.opacity = '0';
                setTimeout(() => {
                    item.style.opacity = '1';
                    item.style.transition = 'opacity 0.3s ease-in-out';
                }, 50);
            } else {
                item.style.display = 'none';
                item.style.opacity = '0';
            }
        });
        
        this.updatePageNumbers();
    }

    nextPage() {
        if (this.currentPage < this.totalPages) {
            this.showPage(this.currentPage + 1);
        }
    }

    previousPage() {
        if (this.currentPage > 1) {
            this.showPage(this.currentPage - 1);
        }
    }
}

// Initialiser la pagination pour chaque liste quand le DOM est chargé
document.addEventListener('DOMContentLoaded', () => {
    const paginationContainers = document.querySelectorAll('[data-pagination]');
    paginationContainers.forEach(container => {
        new Pagination(container);
    });
});