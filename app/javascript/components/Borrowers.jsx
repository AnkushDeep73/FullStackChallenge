import React, { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";

const Borrowers = () => {
  const navigate = useNavigate();
  const [borrowers, setBorrowers] = useState([]);

  useEffect(() => {
    const url = "/api/v1/borrowers/index";
    fetch(url)
      .then((response) => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Error in connecting to the server.");
      })
      .then((response) => setBorrowers(response))
      .catch(() => navigate("/"));
  }, []);

  const allBorrowers = borrowers.map((borrower, index) => (
    <div key={index} className="col-md-6 col-lg-4">
      <div className="card mb-6">
        <div className="card-body">
          <h5 className="card-title">{borrower.name}</h5>
          <Link to={`/borrower/${borrower.id}`} className="btn custom-button">
            View Borrower
          </Link>
        </div>
      </div>
    </div>
  ));
  const noBorrower = (
    <div className="vw-100 vh-50 d-flex align-items-center justify-content-center">
      <h4>
        No borrowers yet. Why not <Link to="/borrower">create one</Link>
      </h4>
    </div>
  );

  return (
    <div className="">
      <section className="jumbotron jumbotron-fluid text-center">
        <div className="container py-5">
          <h1 className="display-4">Borrowers</h1>
          <p className="lead text-muted">
            List of borrowers. Click on a borrower to view the invoices associated to them.
          </p>
        </div>
      </section>
      <div className="py-5">
        <main className="container">
          <div className="text-end mb-3">
            <Link to="/" className="btn btn-link" style={{float: "left"}}>
              Home
            </Link>
            <Link to="/borrower" className="btn custom-button">
              Create New Borrower
            </Link>
          </div>
          <div className="row">
            {borrowers.length > 0 ? allBorrowers : noBorrower}
          </div>
        </main>
      </div>
    </div>
  );
};

export default Borrowers;