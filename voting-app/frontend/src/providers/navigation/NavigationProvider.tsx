import { useEffect, useState } from "react";
import { NavigationContext } from "./NavigationContext";

type NavigationProps = {
	children: React.ReactNode;
};

const NavigationProvider: React.FC<NavigationProps> = ({ children }) => {
	const [currentPage, setCurrentPage] = useState(window.location.pathname);

	const navigate = (page: string) => {
		setCurrentPage(page);
		window.history.pushState({}, "", page);
    };
    useEffect(() => { 
        const handlePopstate = () => { 
            setCurrentPage(window.location.pathname);
        }
        window.addEventListener("popstate", handlePopstate);
        return  () => window.removeEventListener("popstate", handlePopstate);
    });

	return (
		<NavigationContext.Provider value={{ currentPage, navigate }}>
			{children}
		</NavigationContext.Provider>
	);
};

export default NavigationProvider;
