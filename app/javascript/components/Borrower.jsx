import React, { useState, useEffect } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";

const Borrower = () => {
  const params = useParams();
  const navigate = useNavigate();
  const [borrower, setBorrower] = useState({ name: "" });
  const [invoices, setInvoices] = useState([]);

  useEffect(() => {
    const url = `/api/v1/borrowers/show/${params.id}`;
    fetch(url)
      .then((response) => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Error in connecting to the server.");
      })
      .then((response) => { setBorrower(response.borrower); setInvoices(response.invoices); })
      .catch(() => console.log(error.message));
  }, [params.id]);

  const allInvoices = () => {
    return invoices.map((invoice, index) => (
      <div key={index} className="col-md-6 col-lg-4">
        <div className="card mb-6">
          <div className="card-body">
            <h5 className="card-title">{invoice.number}</h5>
            <Link to={`/borrower/${params.id}/invoice/${invoice.id}`} className="btn custom-button">
              View Invoice
            </Link>
          </div>
        </div>
      </div>
    ));
  }
  
  const noInvoice = (
    <div className="vw-100 vh-50 d-flex align-items-center justify-content-center">
      <h4>
        No invoices yet. Why not <Link to={`/borrower/${borrower.id}/invoice`}>create one</Link>
      </h4>
    </div>
  );
  
  return (
    <div className="">
      <section className="jumbotron jumbotron-fluid text-center">
        <div className="container py-5">
          <h1 className="display-4">Invoices for "{borrower.name}"</h1>
          <p className="lead text-muted">
            List of Invoices. Click on an invoices to view the details associated to it.
          </p>
        </div>
      </section>
      <div className="py-5">
        <main className="container">
          <div className="text-end mb-3">
            <Link to="/borrowers" className="btn btn-link" style={{float: "left"}}>
              Back to borrowers
            </Link>
            <Link to={`/borrower/${borrower.id}/invoice`} className="btn custom-button">
              Create New Invoice
            </Link>
          </div>
          <div className="row">
            {invoices.length > 0 ? allInvoices() : noInvoice}
          </div>
        </main>
      </div>
    </div>
  );
};

export default Borrower;